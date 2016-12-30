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

// Convolution Example

// From http://coding-experiments.blogspot.com/2010/07/convolution.html

//#version 150
//
//uniform sampler2D Texture0;
//
//vec4 get_pixel(in vec2 coords, in float dx, in float dy) {
//    return texture2D(Texture0,coords + vec2(dx, dy));
//}
//
//float Convolve(in float[9] kernel, in float[9] matrix,
//               in float denom, in float offset) {
//    float res = 0.0;
//    for (int i=0; i<9; i++) {
//        res += kernel[i]*matrix[i];
//    }
//    return clamp(res/denom + offset,0.0,1.0);
//}
//
//float[9] GetData(in int channel) {
//    float dxtex = 1.0 / float(textureSize(Texture0,0));
//    float dytex = 1.0 / float(textureSize(Texture0,0));
//    float[9] mat;
//    int k = -1;
//    for (int i=-1; i<2; i++) {
//        for(int j=-1; j<2; j++) {
//            k++;
//            mat[k] = get_pixel(gl_TexCoord[0].xy,float(i)*dxtex,
//                               float(j)*dytex)[channel];
//        }
//    }
//    return mat;
//}
//
//float[9] GetMean(in float[9] matr, in float[9] matg, in float[9] matb) {
//    float[9] mat;
//    for (int i=0; i<9; i++) {
//        mat[i] = (matr[i]+matg[i]+matb[i])/3.;
//    }
//    return mat;
//}
//
//void main(void)
//{
//    float[9] kerEmboss = float[] (2.,0.,0.,
//                                  0., -1., 0.,
//                                  0., 0., -1.);
//    
//    float[9] kerSharpness = float[] (-1.,-1.,-1.,
//                                     -1., 9., -1.,
//                                     -1., -1., -1.);
//    
//    float[9] kerGausBlur = float[]  (1.,2.,1.,
//                                     2., 4., 2.,
//                                     1., 2., 1.);
//    
//    float[9] kerEdgeDetect = float[] (-1./8.,-1./8.,-1./8.,
//                                      -1./8., 1., -1./8.,
//                                      -1./8., -1./8., -1./8.);
//    
//    float matr[9] = GetData(0);
//    float matg[9] = GetData(1);
//    float matb[9] = GetData(2);
//    float mata[9] = GetMean(matr,matg,matb);
//    
//    // Sharpness kernel
//    //gl_FragColor = vec4(Convolve(kerSharpness,matr,1.,0.),
//    //                    Convolve(kerSharpness,matg,1.,0.),
//    //                    Convolve(kerSharpness,matb,1.,0.),1.0);
//    
//    // Gaussian blur kernel
//    //gl_FragColor = vec4(Convolve(kerGausBlur,matr,16.,0.),
//    //                    Convolve(kerGausBlur,matg,16.,0.),
//    //                    Convolve(kerGausBlur,matb,16.,0.),1.0);
//    
//    // Edge Detection kernel
//    //gl_FragColor = vec4(Convolve(kerEdgeDetect,mata,0.1,0.),
//    //                    Convolve(kerEdgeDetect,mata,0.1,0.),
//    //                    Convolve(kerEdgeDetect,mata,0.1,0.),1.0);
//    
//    // Emboss kernel
//    gl_FragColor = vec4(Convolve(kerEmboss,mata,1.,1./2.),
//                        Convolve(kerEmboss,mata,1.,1./2.),
//                        Convolve(kerEmboss,mata,1.,1./2.),1.0);
//    
//}

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
//uniform lowp float parameter;
//uniform lowp float time;
//uniform highp vec2 center;


void main()
{
    
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    gl_FragColor = vec4(textureColor);
}

