//
//  RKT_FShader_VerticalStripes.fsh
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

const highp vec2 sampleDivisor = vec2(.001, 1);

void main()
{
    highp vec2 samplePos = textureCoordinate - mod(textureCoordinate, sampleDivisor);
    gl_FragColor = texture2D(inputImageTexture, samplePos );
}