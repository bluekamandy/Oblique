//
//  RKT_FShader_Hue.fsh
//  WYSI™
//
//     /^\˛˛˛˛˛˛˛/^\
//     /« ´ˆˆˆˆˆ` »\
//     |«´¸     ¸`»|
//     {  e     e  }
//     \    (∞)    /
//      |\ `-^-´ /|
//      |  ¨¨¨¨¨  |
//      |         |
//     /    ≈≈≈    \
//     /   ≈≈≈≈≈   \
//    /   ≈≈≈≈≈≈≈   \
//    |  ≈≈≈≈≈≈≈≈≈  |
//
//
//  RIKI TIKI INC.
//  © 2016 All Rights Reserved
//
//  Last updated 3/24/2016
//
//  More information at support@rikitiki.io

#define M_PI 3.1415926535897932384626433832795

precision highp float;
varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
//uniform mediump float hueAdjust;
const highp  vec4  kRGBToYPrime = vec4 (0.299, 0.587, 0.114, 0.0);
const highp  vec4  kRGBToI     = vec4 (0.595716, -0.274453, -0.321263, 0.0);
const highp  vec4  kRGBToQ     = vec4 (0.211456, -0.522591, 0.31135, 0.0);

const highp  vec4  kYIQToR   = vec4 (1.0, 0.9563, 0.6210, 0.0);
const highp  vec4  kYIQToG   = vec4 (1.0, -0.2721, -0.6474, 0.0);
const highp  vec4  kYIQToB   = vec4 (1.0, -1.1070, 1.7046, 0.0);

uniform highp vec2 center;

void main ()
{
    // Sample the input pixel
    highp vec4 color   = texture2D(inputImageTexture, textureCoordinate);
    
    // Scale center.x to pi
    highp float centerScaled = center.x * M_PI * 2.0;
    
    // Convert to YIQ
    highp float   YPrime  = dot (color, kRGBToYPrime);
    highp float   I      = dot (color, kRGBToI);
    highp float   Q      = dot (color, kRGBToQ);
    
    // Calculate the hue and chroma
    highp float   hue     = atan (Q, I);
    highp float   chroma  = sqrt (I * I + Q * Q);
    
    // Make the user's adjustments
    hue += (-centerScaled); //why negative rotation?
    
    // Convert back to YIQ
    Q = chroma * sin (hue);
    I = chroma * cos (hue);
    
    // Convert back to RGB
    highp vec4    yIQ   = vec4 (YPrime, I, Q, 0.0);
    color.r = dot (yIQ, kYIQToR);
    color.g = dot (yIQ, kYIQToG);
    color.b = dot (yIQ, kYIQToB);
    
    // Save the result
    gl_FragColor = color;
}