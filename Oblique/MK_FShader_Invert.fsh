// Check here for the answer:
// http://stackoverflow.com/questions/31997762/gpuimage-shader-crashing-with-error-one-or-more-attached-shaders-not-successfu

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;


void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    if (parameter > 0.0) {
        gl_FragColor = vec4(vec3(parameter - textureColor.rgb), textureColor.a);
    } else {
        gl_FragColor = vec4(vec3(textureColor.rgb), textureColor.a);
    }
}

