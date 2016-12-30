//
//  RKT_FShader_Contrast.fsh
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

uniform sampler2D inputImageTexture;
//uniform lowp float parameter;
//uniform lowp float time;
uniform highp vec2 center;


void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    // Scalar to adjust to touch parameters being fed in.
    highp float centerScaled = 4.0 * center.x;
    
    gl_FragColor = vec4(((textureColor.rgb - vec3(0.5)) * centerScaled + vec3(0.5)), textureColor.a);
}


