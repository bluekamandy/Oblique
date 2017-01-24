//
//  RKT_FShader_Stretch.fsh
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

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;

void main()
{
    // Converts from range [0,1] to [-1,1]
    highp vec2 normCoord = 2.0 * textureCoordinate - 1.0;
    highp vec2 normCenter = 2.0 * center - 1.0;
    
    normCoord -= normCenter;
    
    // sign returns -1.0 if x is less than 0.0, 0.0 if x is equal to 0.0, and +1.0 if x is greater than 0.0.
    mediump vec2 s = sign(normCoord);
    normCoord = abs(normCoord);
    normCoord = 0.5 * normCoord + 0.5 * smoothstep(0.25, 0.5, normCoord) * normCoord;
    normCoord = s * normCoord;
    
    normCoord += normCenter;
    
    mediump vec2 textureCoordinateToUse = normCoord / 2.0 + 0.5;
    
    
    gl_FragColor = texture2D(inputImageTexture, textureCoordinateToUse );
}
