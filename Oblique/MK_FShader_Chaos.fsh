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

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform highp float parameter;
uniform highp float time;
uniform highp vec2 center;
uniform int easterEgg;

//highp float map(highp float value, highp float low1, highp float high1, highp float low2, highp float high2) {
//    return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
//}
//
//
//highp float random (highp vec2 st) {
//    // Original Random Function
//    return fract(sin(dot(st.xy, vec2(.9898,41414442.233)))* 43758.5453123);
//
////        return fract(sin(dot(st.xy, vec2(.9898,41414442.233)))* control);
//}

//void main() {
//
//    highp float interpX = mix(0., 5.0, center.x);
//
//    highp float interpY = mix(0., 1.0, center.y);
//
//    highp float refractiveIndex = 1.5;
//    highp vec2 refractedDirection = refract(vec2(center.y), -textureCoordinate, 1.0/interpX);
////    highp float remappedX = map(center.x, 0., 1., 0., 50000.);
////    highp vec2 st = textureCoordinate.xy;
////    highp float rnd = random( st );
//
////    highp vec2 texCoordToUse = vec2(mod(st.x+rnd/100., 1.), mod(st.y-rnd/10., 1.));
//
////    highp vec4 textureColor = texture2D(inputImageTexture, mod(texCoordToUse+rnd/(center.x*10.), 1.0));
////    highp vec4 textureColor = texture2D(inputImageTexture, st);
//
//    highp vec4 sample0 = texture2D(inputImageTexture, mod(refractedDirection*2., 1.0));
//
//    gl_FragColor = sample0;
//}

#define SIN01(a) (sin(a)*0.5 + 0.5)

highp vec3 rgb2hsv(highp vec3 c)
{
    highp vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    highp vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    highp vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    
    highp float d = q.x - min(q.w, q.y);
    highp float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}


void main()
{
    highp vec2 interp = vec2(mix(0., 2.5, center.x),
                             mix(0., 2.5, center.y));
    highp vec3 hsv = rgb2hsv(texture2D(inputImageTexture, textureCoordinate).rgb);
    
    highp float angle = hsv.x + atan(textureCoordinate.y, textureCoordinate.x) + interp.x;
    highp mat2 RotationMatrix = mat2( cos( angle ), -sin( angle ), sin( angle ),  cos( angle ));
    highp vec3 col = texture2D(inputImageTexture, textureCoordinate + RotationMatrix * vec2(log(max(SIN01(interp.y)-0.2, 0.)*0.2 + 1.  ),0) * hsv.y).rgb;
    
    gl_FragColor = vec4(col,1.0);
}
