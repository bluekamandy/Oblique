//
//  RKT_FShader_Shear.fsh
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
    
    highp vec2 shiftedCoordinates = textureCoordinate /* * 2.0 - 1.0*/;
    
    lowp mat2 shear = mat2(
                      1.0, center.x*5.0,
                      center.y*5.0, 1.0
                      );
    
    lowp vec4 textureColor = texture2D(inputImageTexture, fract(shiftedCoordinates*shear));
    
    gl_FragColor = vec4(textureColor.rgb, textureColor.a);
}

