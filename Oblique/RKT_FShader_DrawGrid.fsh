varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
uniform lowp float time;
uniform highp vec2 center;

highp float grid( highp vec2 p, highp float width ) {
    p += width * 0.5;
    
    highp float grid_width = 1.0;
    highp float k = 1.0;
    
    k *= step( width * 2.0, abs( p.x ) );
    k *= step( width * 2.0, abs( p.y ) );
    
    grid_width *= 0.25;
    k *= min( step( width, abs( floor( p.x / grid_width + 0.5 ) * grid_width - p.x ) ) + 0.75, 1.0 );
    k *= min( step( width, abs( floor( p.y / grid_width + 0.5 ) * grid_width - p.y ) ) + 0.75, 1.0 );
    
    return k;	
}

void main()
{
    highp float width = 0.25;
    
    //highp vec2 normCoord = textureCoordinate - vec2(.5);
    
    lowp vec4 textureColor = texture2D(inputImageTexture, fract(textureCoordinate - center));
    
    highp float k_grid = grid( textureCoordinate, width );
    
    gl_FragColor = vec4(textureColor.rgb * k_grid, textureColor.a * k_grid);
}

