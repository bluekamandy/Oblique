//
//  RKT_FShader_Polar.fsh
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
//  Last updated 4/14/2016
//
//  More information at support@rikitiki.io

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;

void main()
{
    highp vec2 normCoord = textureCoordinate - vec2(.5);
    highp vec2 normCenter = 2.0 * vec2(.5) - 1.0;
    
    normCoord -= normCenter;
    
    highp float radius = length(normCoord);
    highp float angle = -atan(normCoord.y, normCoord.x);
    mediump vec2 textureCoordinateToUse = normCoord + 0.5;
    
    
    highp vec4 color = texture2D(inputImageTexture, vec2(radius, 0.0));
    gl_FragColor = vec4(color.rgb , 1.0);
    
}