//
//  RKT_FShader_4Split.fsh
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


precision mediump float;
uniform sampler2D inputImageTexture;
uniform lowp float u_blurStep;
varying highp vec2 textureCoordinate;


uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;

highp float map(highp float value, highp float low1, highp float high1, highp float low2, highp float high2) {
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
}

void main()
{
    highp vec4 sample0, sample1, sample2, sample3;
    
    highp float fStep = map(center.x, 0., 1., -0.01, .5); // Mapped it to give it a little space from the edge.
    
    sample0 = texture2D(inputImageTexture, vec2(textureCoordinate.x - fStep, textureCoordinate.y - fStep));
    sample1 = texture2D(inputImageTexture, vec2(textureCoordinate.x + fStep, textureCoordinate.y + fStep));
    sample2 = texture2D(inputImageTexture, vec2(textureCoordinate.x + fStep, textureCoordinate.y - fStep));
    sample3 = texture2D(inputImageTexture, vec2(textureCoordinate.x - fStep, textureCoordinate.y + fStep));
    lowp vec4 textureColor = texture2D(inputImageTexture, fract(textureCoordinate));
    
    gl_FragColor = vec4(((sample0 + sample1 + sample2 + sample3)/4.0));
}

