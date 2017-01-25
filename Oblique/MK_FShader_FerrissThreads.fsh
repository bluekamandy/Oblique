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
// ROTATE AROUND DIFFERENT ORIGIN
// ------------------------------------------------------------
//highp vec2 rotateAroundPoint(highp float angle, highp vec2 texCoord, highp vec2 rotationPoint) {
//    return vec2(cos(angle) * (texCoord.x - rotationPoint.x) + sin(angle) * (texCoord.y - rotationPoint.y) + rotationPoint.x,
//                cos(angle) * (texCoord.y - rotationPoint.y) - sin(angle) * (texCoord.x - rotationPoint.x) + rotationPoint.y);
//}
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

// SOURCE: https://www.shadertoy.com/view/Ml2Szz

// Directionality of touch SOURCE: https://www.shadertoy.com/view/XltGWS

// Adam Ferriss Clamp. Used at his suggestion: https://www.shadertoy.com/view/MtyXRc


varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform highp float parameter;
//uniform lowp float time;
uniform highp vec2 center;


void main()
{
    highp vec4 t;
    
    if (parameter < .9){
        //vertical stripes
        t = texture2D(inputImageTexture, vec2(mod(textureCoordinate.x + center.x, 1.0), clamp(textureCoordinate.y, 0.0, 0.001) + center.y));
    } else if (parameter < 1.9 && parameter > .9) {
        //horizontal halfsies
        t = texture2D(inputImageTexture, vec2(clamp(textureCoordinate.x, center.x - 0.001, center.x), mod(textureCoordinate.y + center.y, 1.0)));
    } else if (parameter < 2.9 && parameter > 1.9) {
        //top down curtain
        t = texture2D(inputImageTexture, vec2(textureCoordinate.x, clamp(textureCoordinate.y, center.y, 1.0 )));
    } else if (parameter < 3.9 && parameter > 2.9) {
        //left right curtain
        t = texture2D(inputImageTexture, vec2(clamp(textureCoordinate.x, 0.0, center.x), textureCoordinate.y));
    } else if (parameter < 4.9 && parameter > 3.9) {
        //horizontal stripes meet in the middle
        t = texture2D(inputImageTexture, vec2(mod(clamp(textureCoordinate.x, 1.0 - center.x, center.x)+center.y, 1.0), textureCoordinate.y));
    } else if (parameter < 5.9 && parameter > 4.9) {
        //vertical stripes meet in the middle
        t = texture2D(inputImageTexture, vec2(textureCoordinate.x, mod(clamp(textureCoordinate.y, 1.0 - center.y, center.y) + center.x, 1.0)));
    }
    
    gl_FragColor = t;
}
