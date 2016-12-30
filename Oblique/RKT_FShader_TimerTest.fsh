varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;


void main()
{
    
    lowp vec4 textureColor = texture2D(inputImageTexture, fract(textureCoordinate));
    
    gl_FragColor = vec4(time, 1.0, 1.0, 1.0);
}

