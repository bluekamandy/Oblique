
varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;

const highp vec2 sampleDivisor = vec2(1, .001);

void main()
{
    highp vec2 samplePos = textureCoordinate - mod(textureCoordinate, sampleDivisor);
    gl_FragColor = texture2D(inputImageTexture, samplePos );
}