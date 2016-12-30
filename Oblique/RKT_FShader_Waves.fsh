//
//  RKT_FShader_Waves.fsh
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
   	lowp vec2 uv = textureCoordinate;
    
    uv.y += (cos((uv.y + (time * 0.04)) * 45.0) * center.y/2.0) +
    (cos((uv.y + (time * 0.1)) * 10.0) * 0.01);
    
    uv.x += (sin((uv.y + (time * 0.07)) * 15.0) * center.x/2.0) +
    (sin((uv.y + (time * 0.1)) * 15.0) * 0.01);
    
    
    lowp vec4 texColor = texture2D(inputImageTexture, fract(uv));
    gl_FragColor = texColor;
    
 
}


