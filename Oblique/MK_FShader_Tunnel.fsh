//
//  RKT_FShader_Tunnel.fsh
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
//  Last updated 3/15/2016
//
//  More information at support@rikitiki.io

#define M_PI 3.1415926535897932384626433832795
#define M_TAU 6.2831853071795864769252867665590

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;

highp float map(highp float value, highp float low1, highp float high1, highp float low2, highp float high2) {
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
}

void main()
{
    highp vec2 normCoord = textureCoordinate - vec2(.5);
    highp vec2 normCenter = 2.0 * vec2(.5) - 1.0;
    
    normCoord -= normCenter;
    
    highp float radius = length(normCoord);
    highp float angle = -atan(normCoord.y, normCoord.x);
    mediump vec2 textureCoordinateToUse = normCoord + 0.5;
    
    
    highp vec4 color = texture2D(inputImageTexture, vec2(radius, fract(angle / ( map(center.x, 0.0, 1.0, 20.0, 0.0) / (M_PI)) )));
    gl_FragColor = vec4(color.rgb , 1.0);

}