//
//  RKT_FShader_overMirror.fsh
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



void main()
{
    //    float c = center.x;
    //
    //    vec2 uv = textureCoordinate;
    //
    //    uv.x += step(uv.x, 0.5) * (0.5-uv.x) * 2.0;
    //    uv.y += step(uv.y, 0.5) * (0.5-uv.y) * 2.0;
    //
    //    uv.x -= cos(c/20.0) * 0.5; //step(sin(t),0.2);
    //    uv.y -= sin(c/5.0) * 1.5; //step(sin(t),0.2);
    //
    //    gl_FragColor = texture2D(inputImageTexture, uv);
    
    
    highp vec2 normCoord = vec2((1. - 2.*abs(1./2. - fract(1./2.*textureCoordinate.x + 1./4.))), (1. - 2.*abs(1./2. - fract(1./2.*textureCoordinate.y + 1./4.))));
    
    
    highp vec4 textureColor = texture2D(inputImageTexture, normCoord);
    
    gl_FragColor = vec4(textureColor.rgb, textureColor.a);
    
}
