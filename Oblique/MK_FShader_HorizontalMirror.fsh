//
//  RKT_FShader_HorizontalMirror.fsh
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
    
    // highp vec2 normCoord = textureCoordinate - vec2(0., (1. - 4.*abs(1./2. - fract(1./2.*textureCoordinate.y + 1./4.))));
    
    // WORKS FOR VERTICAL MIRROR, BUT I NEED TO MAKE IT SO THAT IT DOESN'T DISTORT.
    // highp vec2 normCoord = vec2(textureCoordinate.x, (1. - 4.*abs(1./2. - fract(1./2.*textureCoordinate.y + 1./4.))));
    
    highp vec2 normCoord = vec2((1. - 2.*abs(1./2. - fract(1./2.*textureCoordinate.x + 1./4.))), textureCoordinate.y);
    
    
    highp vec4 textureColor = texture2D(inputImageTexture, normCoord);
    
    gl_FragColor = vec4(textureColor.rgb, textureColor.a);
}

