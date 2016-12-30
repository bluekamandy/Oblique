precision mediump float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;

uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;

highp vec4 textureColor;

void main()
{
    vec2 textureCoordinateToUse = textureCoordinate;
    vec3 color = vec3(0.0);
    
    // Get RGB values from the camera. Store them in 'textureColor.'
    textureColor = texture2D(inputImageTexture, textureCoordinateToUse);
    
    textureColor.r = fract(textureColor.r+center.x);

    textureColor.g = fract(textureColor.g+center.y);

    textureColor.b = fract(textureColor.b+center.x/center.y);
 
    color = vec3(textureColor.r,textureColor.g,textureColor.b);
    
    gl_FragColor = vec4(vec3(color), 1.0 );
}