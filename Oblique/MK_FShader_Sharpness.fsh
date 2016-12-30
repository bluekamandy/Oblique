//
//  RKT_FShader_Sharpness.fsh
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

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture, uBeforeUnit, uAfterUnit;

uniform highp float uAng;
uniform highp float uResX, uResY;

uniform highp vec2 center;

void main( )
{
    highp vec3 irgb = texture2D( inputImageTexture,  textureCoordinate ).rgb;
    highp vec3 brgb = texture2D( uBeforeUnit, textureCoordinate ).rgb;
    highp vec3 argb = texture2D( uAfterUnit,  textureCoordinate ).rgb;
    highp vec4 color = vec4( 1., 0., 0., 1. );

    highp vec2 stp0 = vec2(1./uResX,  0. );
    highp vec2 st0p = vec2(0.     ,  1./uResY);
    highp vec2 stpp = vec2(1./uResX,  1./uResY);
    highp vec2 stpm = vec2(1./uResX, -1./uResY);
    highp vec3 i00 =   texture2D( inputImageTexture, textureCoordinate ).rgb;
    highp vec3 im1m1 = texture2D( inputImageTexture, textureCoordinate-stpp ).rgb;
    highp vec3 ip1p1 = texture2D( inputImageTexture, textureCoordinate+stpp ).rgb;
    highp vec3 im1p1 = texture2D( inputImageTexture, textureCoordinate-stpm ).rgb;
    highp vec3 ip1m1 = texture2D( inputImageTexture, textureCoordinate+stpm ).rgb;
    highp vec3 im10 =  texture2D( inputImageTexture, textureCoordinate-stp0 ).rgb;
    highp vec3 ip10 =  texture2D( inputImageTexture, textureCoordinate+stp0 ).rgb;
    highp vec3 i0m1 =  texture2D( inputImageTexture, textureCoordinate-st0p ).rgb;
    highp vec3 i0p1 =  texture2D( inputImageTexture, textureCoordinate+st0p ).rgb;
    highp vec3 target = vec3(0.,0.,0.);
    target += 1.*(im1m1+ip1m1+ip1p1+im1p1);
    target += 2.*(im10+ip10+i0m1+i0p1);
    target += 4.*(i00);
    target /= 16.;
    color = vec4( mix( target, irgb, vec3(center.x)), 1. );

    gl_FragColor = color;
}
