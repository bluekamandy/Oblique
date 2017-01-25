// USEFUL CODE
// ------------------------------------------------------------
//
// DEFINITIONS OF PI AND TAU
// ------------------------------------------------------------
// #define M_PI 3.1415926535897932384626433832795
// #define M_TAU 6.2831853071795864769252867665590
//
// CENTERING COORDINATE SPACE
// ------------------------------------------------------------
// ???
//
// REMAPPING FUNCTION FOR GLSL
// ------------------------------------------------------------
// low2 + (value - low1) * (high2 - low2) / (high1 - low1)
//
// highp float map(highp float value, highp float low1, highp float high1, highp float low2, highp float high2) {
//     return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
// }
//
// CONVERTS FROM RANGE [0,1] TO [-1,1]
// ------------------------------------------------------------
// highp vec2 normCoord = 2.0 * textureCoordinate - 1.0;
// highp vec2 normCenter = 2.0 * center - 1.0;
//
// USE POLAR COORDINATES INSTEAD OF CARTESIAN
// ------------------------------------------------------------
// vec2 toCenter = vec2(0.5) - textureCoordinate;
// float angle = atan(toCenter.y,toCenter.x);
// float radius = length(toCenter)*2.0;
//
// MATRIX FOR ROTATION
// ------------------------------------------------------------
// ???
//
// MATRIX FOR SHEAR
// ------------------------------------------------------------
// ???
//
// BRESENHAM'S LINE ALGORITHM
// ------------------------------------------------------------
// void line(x0, y0, x1, y1) {
//     float deltax = x1 - x0;
//     float deltay = y1 - y0;
//     float error = 0;
//     float deltaerr = abs(deltay / deltax)
//     // Assume deltax != 0 (line is not vertical),
//     // note that this division needs to be done in a way
//     // that preserves the fractional part
//     int y = y0;
//     for (int x = x0; x ++; x <= x1) {
//             plot(x,y)
//         error = error + deltaerr
//         while (error ≥ 0.5) {
//             plot(x, y);
//             y = y + sign(y1 - y0)
//             error := error - 1.0
//         }
// }
//
// FAST RGB TO HSV CONVERSION
// ------------------------------------------------------------
// vec3 rgb2hsv(vec3 c)
// {
//     vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
//     vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
//     vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);
//
//     float d = q.x - min(q.w, q.y);
//     float e = 1.0e-10;
//     return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
// }
// SOURCE: http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
//
//
// FAST HSV TO RGB CONVERSION
// ------------------------------------------------------------
// vec3 hsv2rgb(vec3 c)
// {
//     vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
//     vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
//     return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
// }
// SOURCE: http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
//
//
// REINHARD TONEMAPPING
// ------------------------------------------------------------
// Based on Filmic Tonemapping Operators http://filmicgames.com/archives/75
//
// vec3 tonemapReinhard(vec3 color) {
//     return color / (color + vec3(1.0));
// }

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float parameter;
//uniform lowp float time;
uniform highp vec2 center;

highp float map(highp float value, highp float low1, highp float high1, highp float low2, highp float high2) {
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
}


void main()
{
    highp float remappedX = map(center.x, 0., 1., 1., 20.0);
    highp float remappedY = map(center.y, 0., 1., 1., 20.0);
    
    highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    highp float redTextureColor = texture2D(inputImageTexture, textureCoordinate).r;
    highp float redModulus = fract(redTextureColor * remappedX);
    
    highp float greenTextureColor = texture2D(inputImageTexture, textureCoordinate).g;
    highp float greenModulus = fract(greenTextureColor * remappedX);
    
    highp float blueTextureColor = texture2D(inputImageTexture, textureCoordinate).b;
    highp float blueModulus = fract(blueTextureColor * remappedX);
       
    gl_FragColor = vec4(vec3(redModulus, greenModulus, blueModulus), textureColor.a);
}

