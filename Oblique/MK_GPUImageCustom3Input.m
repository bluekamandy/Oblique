//
//  MK_GPUImageCustom3Input.m
//  Oblique™
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
//  by Masood Kamandy
//  © 2016 All Rights Reserved
//
//  Last updated 12/29/2016
//
//  More information at masoodkamandy@gmail.com

#import "MK_GPUImageCustom3Input.h"
#import "MK_PausableTimer.h"

// Maximum amount of time before the timer resets to 0.
// This helps with some trig functions, which become
// more expensive as the time increases.

#define MAX_TIMER 30

@interface MK_GPUImageCustom3Input ()
{
    MK_PausableTimer *timer;
}

@property(readwrite, nonatomic) GLfloat time;

@end

#pragma mark - Default Vertex Shader

NSString *const kMK_GPUImageCustom3InputVertexShaderString = SHADER_STRING
(
 attribute vec4 position;
 attribute vec4 inputTextureCoordinate;
 
 varying vec2 textureCoordinate;
 
 void main()
 {
     gl_Position = position;
     textureCoordinate = inputTextureCoordinate.xy;
 }
 );

#pragma mark - Default Fragment Shader

NSString *const kMK_GPUImageCustom3InputFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform highp float parameter;
 uniform highp float time;
 uniform highp vec2 center;
 uniform int easterEgg;
 
 
 void main()
 {
     highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     gl_FragColor = vec4((textureColor.rgb), textureColor.w);
 }
 );


@implementation MK_GPUImageCustom3Input

@synthesize parameter = _parameter;
@synthesize center = _center;
@synthesize time = _time;
@synthesize easterEgg = _easterEgg;

#pragma mark - Initialization and teardown

- (id)initWithVertexShaderFromFile:(NSString *)vertexShaderFilename fragmentShaderFromFile:(NSString *)fragmentShaderFilename timerOn:(BOOL)t
{
    NSString *vertexShaderPathname = [[NSBundle mainBundle] pathForResource:vertexShaderFilename ofType:@"vsh"];
    NSString *vertexShaderString = [NSString stringWithContentsOfFile:vertexShaderPathname encoding:NSUTF8StringEncoding error:nil];
    
    NSString *fragmentShaderPathname = [[NSBundle mainBundle] pathForResource:fragmentShaderFilename ofType:@"fsh"];
    NSString *fragmentShaderString = [NSString stringWithContentsOfFile:fragmentShaderPathname encoding:NSUTF8StringEncoding error:nil];
    
    
    if (!(self = [self initWithVertexShaderFromString:vertexShaderString fragmentShaderFromString:fragmentShaderString]))
    {
        return nil;
    }
    
    parameterUniform = [filterProgram uniformIndex:@"parameter"];
    self.parameter = 0.0;
    
    centerUniform = [filterProgram uniformIndex:@"center"];
    self.center = CGPointMake(0.25, 0.25);
    
    timeUniform = [filterProgram uniformIndex:@"time"];
    self.time = 0.0;
    
    easterEggUniform = [filterProgram uniformIndex:@"easterEgg"];
    self.easterEgg = 0;
    
    if (t) {
        
        timer = [MK_PausableTimer timerWithTimeInterval:.01 target:self selector:@selector(incrementTime:) userInfo:nil repeats:YES];
        [timer start];
//        NSLog(@"Timer has started");
    } else {
        timer = nil;
    }

    
    return self;
}



- (id)initWithFragmentShaderFromFile:(NSString *)fragmentShaderFilename timerOn:(BOOL)t
{
    if (!(self = [super initWithFragmentShaderFromFile:fragmentShaderFilename]))
    {
        return nil;
    }
    
    
    parameterUniform = [filterProgram uniformIndex:@"parameter"];
    self.parameter = 0.0;
    
    centerUniform = [filterProgram uniformIndex:@"center"];
    self.center = CGPointMake(0.25, 0.25);
    
    timeUniform = [filterProgram uniformIndex:@"time"];
    self.time = 0.0;
    
    easterEggUniform = [filterProgram uniformIndex:@"easterEgg"];
    self.easterEgg = 0;

    
    if (t) {
        
        timer = [MK_PausableTimer timerWithTimeInterval:.01 target:self selector:@selector(incrementTime:) userInfo:nil repeats:YES];
        [timer start];
//        NSLog(@"Timer has started");
    } else {
        timer = nil;
    }
    
    
    return self;
}


- (id)initWithFragmentShaderFromFile:(NSString *)fragmentShaderFilename
{
    if (!(self = [super initWithFragmentShaderFromFile:fragmentShaderFilename]))
    {
        return nil;
    }
    
    
    parameterUniform = [filterProgram uniformIndex:@"parameter"];
    self.parameter = 0.0;
    
    centerUniform = [filterProgram uniformIndex:@"center"];
    self.center = CGPointMake(0.25, 0.25);
    
    timeUniform = [filterProgram uniformIndex:@"time"];
    self.time = 0.0;
    
    easterEggUniform = [filterProgram uniformIndex:@"easterEgg"];
    self.easterEgg = 0;

    
    timer = nil;
    
    return self;
}

- (id)init;
{
    
    if (!(self = [super initWithFragmentShaderFromString:kMK_GPUImageCustom3InputFragmentShaderString]))
    {
        return nil;
    }
    
    parameterUniform = [filterProgram uniformIndex:@"parameter"];
    self.parameter = 0.0;
    
    centerUniform = [filterProgram uniformIndex:@"center"];
    self.center = CGPointMake(0.25, 0.25);
    
    timeUniform = [filterProgram uniformIndex:@"time"];
    self.time = 0.0;
    
    easterEggUniform = [filterProgram uniformIndex:@"easterEgg"];
    self.easterEgg = 0;
    
    timer = nil;
    
    return self;
}



#pragma mark - Accessors


- (void)setInputRotation:(GPUImageRotationMode)newInputRotation atIndex:(NSInteger)textureIndex
{
    [super setInputRotation:newInputRotation atIndex:textureIndex];
    [self setCenter:self.center];
}

- (void)setParameter:(CGFloat)newValue
{
    _parameter = newValue;
    
    [self setFloat:_parameter forUniform:parameterUniform program:filterProgram];
}

- (void)setCenter:(CGPoint)newValue
{
    _center = newValue;
    
    CGPoint rotatedPoint = [self rotatedPoint:_center forRotation:inputRotation];
    [self setPoint:rotatedPoint forUniform:centerUniform program:filterProgram];
}

- (void)setTime:(GLfloat)time
{
    _time = time;
    
    [self setFloat:_time forUniform:timeUniform program:filterProgram];
}

- (void)setEasterEgg:(int)easterEgg
{
    _easterEgg = easterEgg;
    
    [self setInteger:_easterEgg forUniform:easterEggUniform program:filterProgram];
}

#pragma mark - Private Timer Actions


- (void)incrementTime:(MK_PausableTimer*)timer
{
    //Only if you need a very small repeating counter up to 100 and back to 0.
    (self.time) < (MAX_TIMER) ? (self.time += 0.01) : (self.time = 0.0);
    
    // This is a normal timer.
    //    self.time += .01;
    //    NSLog(@"%f", self.time);
    
}


#pragma mark - Overrides

- (void)removeAllTargets
{
    [super removeAllTargets];
    
    if(timer != nil)
    {
//        NSLog(@"Timer has been deallocated");
        timer = nil;
    }
    
}

@end
