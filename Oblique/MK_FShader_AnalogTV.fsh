//
//  RKT_FShader_AnalogTV.fsh
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

void main(void) {
    highp vec2 position = textureCoordinate;
    position.y *=-1.0;
    lowp vec3 color;
    
    //color separation
    color.r = texture2D(inputImageTexture,vec2(position.x+0.002,-position.y)).x;
    color.g = texture2D(inputImageTexture,vec2(position.x+0.000,-position.y)).y;
    color.b = texture2D(inputImageTexture,vec2(position.x-0.002,-position.y)).z;
    
    //contrast
    color = clamp(color*0.5+0.5*color*color*1.2,0.0,1.0);
    
    //circular vignette fade
    color *= 0.5 + 0.5*16.0*position.x*position.y*(1.0-position.x)*(-1.0-position.y);
    
    //color shift
    //color *= vec3(0.8,1.0,0.7); //green
    color *= vec3(0.95,0.85,1.0); //blue
    //color *= vec3(1.0,0.8,0.1); //red
    //color *= vec3(1.0,0.7,1.0); //purple
    //color *= vec3(0.7,1.0,1.0); //cyan
    //color *= vec3(1.0,1.0,0.7); //yellow
    //float gray = dot(color, vec3(0.299, 0.587, 0.114));
    //color = vec3(gray, gray, gray); //gray
    
    //tvlines effect
    color *= 0.9+0.1*sin(10.0*time+position.y*1000.0);
    
    //tv flicker effect
    color *= 0.97+0.03*sin(110.0*time);
    
    gl_FragColor = vec4(color,1.0);
}