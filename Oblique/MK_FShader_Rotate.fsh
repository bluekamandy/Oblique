//
//  RKT_FShader_Water.fsh
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
//  Last updated 3/13/2016
//
//  More information at support@rikitiki.io

#define M_PI 3.1415926535897932384626433832795

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;



void main()
{
    
    highp vec2 shiftedCoordinates = textureCoordinate - 0.5;
    
    lowp mat2 shear = mat2(
                      cos(center.x * M_PI), -sin(center.x * M_PI),
                      sin(center.x * M_PI), cos(center.x * M_PI)
                      );
    
    lowp vec4 textureColor = texture2D(inputImageTexture, fract(shiftedCoordinates*shear));
    
    gl_FragColor = vec4(textureColor.rgb, textureColor.a);
}

