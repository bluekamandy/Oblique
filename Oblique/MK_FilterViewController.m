//
//  MK_FilterViewController.m
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

#import "MK_FilterViewController.h"
#import "MK_FilterViewCell.h"
#import "MK_Shader.h"
#import "MK_ShaderGroup.h"
#import "MK_GPUImageCameraManager.h"
#import <GPUImage/GPUImage.h>

@interface MK_FilterViewController ()
{
    NSInteger *filterNumber;
    MK_Shader *shaderDatabase;
    MK_GPUImageCameraManager *cameraManager;
}


@end

@implementation MK_FilterViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    shaderDatabase = [[MK_Shader alloc] init];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shaderDatabase.filtersAvailable count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    MK_FilterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil)
    {
        cell = [[MK_FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    SEL s = NSSelectorFromString([shaderDatabase.filtersAvailable objectAtIndex:indexPath.row]);
    cell.filterGroup = [MK_Shader performSelector:s];
    NSLog(@"%@", NSStringFromSelector(s));
    cameraManager = [MK_GPUImageCameraManager sharedManager];
    
    [cell.filterGroup forceProcessingAtSize:cell.filterView.sizeInPixels];
    
    [cameraManager.stillCamera addTarget:cell.filterGroup];
    
    [cell.filterGroup addTarget: cell.filterView];
    
    
    UILabel *filterNameLabel = (UILabel *)[cell viewWithTag:101];
    filterNameLabel.text = [cell.filterGroup.title uppercaseString];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MK_GPUImageCameraManager *sharedCameraManager = [MK_GPUImageCameraManager sharedManager];
    
    NSLog(@"%@", [shaderDatabase.filtersAvailable objectAtIndex:indexPath.row]);
    [sharedCameraManager changeToFilter:[shaderDatabase.filtersAvailable objectAtIndex:indexPath.row]];
    NSLog(@"Filter number set to %ld", (long)indexPath.row + 1);
    
}


@end
