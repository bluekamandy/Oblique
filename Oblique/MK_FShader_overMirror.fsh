//
//  RKT_FShader_4Scope.fsh
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
//varying highp vec2 textureCoordinate2;

uniform sampler2D inputImageTexture;
//uniform sampler2D inputImageTexture2;

void main()
{
    lowp vec4 base = texture2D(inputImageTexture, textureCoordinate);
    lowp vec4 overlayer = texture2D(inputImageTexture, textureCoordinate*mat2(-1.,0.,0.,1.)+vec2(1.,0.));
    
    gl_FragColor = vec4(min(overlayer.rgb * base.a, base.rgb * overlayer.a) + overlayer.rgb * (1.0 - base.a) + base.rgb * (1.0 - overlayer.a), 1.0);
}
