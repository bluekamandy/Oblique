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
    NSIndexPath *selectedRow;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [shaderDatabase.filterSectionTitles count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSLog(@"Section Header being called: %@", [shaderDatabase.filterSectionTitles objectAtIndex:section]);
//    return [shaderDatabase.filterSectionTitles objectAtIndex:section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"Header";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *sectionTitle = [shaderDatabase.filterSectionTitles objectAtIndex:section];
    
    UILabel *label = (UILabel *)[headerView viewWithTag:777];
    [label setText:[sectionTitle uppercaseString]];
    
    return headerView;
    
}

// Using a transparent footer to add a bit of space between the last filter and the next section.
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"Footer";
    UITableViewCell *footerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            return 40;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [shaderDatabase.filterSectionTitles objectAtIndex:section];
    NSArray *sectionFilter = [shaderDatabase.filtersAvailable objectForKey:sectionTitle];
    return [sectionFilter count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    MK_FilterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[MK_FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *sectionTitle = [shaderDatabase.filterSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionFilter = [shaderDatabase.filtersAvailable objectForKey:sectionTitle];
    
    SEL s = NSSelectorFromString([sectionFilter objectAtIndex:indexPath.row]);
    cell.filterGroup = [MK_Shader performSelector:s];
    //    NSLog(@"%@", NSStringFromSelector(s));
    cameraManager = [MK_GPUImageCameraManager sharedManager];
    
    [cell.filterGroup forceProcessingAtSize:cell.filterView.sizeInPixels];
    
    [cameraManager.stillCamera addTarget:cell.filterGroup];
    
    [cell.filterGroup addTarget: cell.filterView];
    
    
    UILabel *filterNameLabel = (UILabel *)[cell viewWithTag:101];
    filterNameLabel.text = [cell.filterGroup.title uppercaseString];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // SOURCE: http://stackoverflow.com/questions/897071/iphone-uitableview-cells-stay-selected/35605984#35605984
    
//    NSLog(@"selectedRow: %@ and indexPath: %@", selectedRow, indexPath);
    
    if ([selectedRow isEqual:indexPath]) {
        [cell setSelected:YES];
        [cell setHighlighted:YES];
//        NSLog(@"YES");
    } else {
        [cell setSelected:NO];
        [cell setHighlighted:NO];
//        NSLog(@"NO");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MK_GPUImageCameraManager *sharedCameraManager = [MK_GPUImageCameraManager sharedManager];
    
    NSString *sectionTitle = [shaderDatabase.filterSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionFilter = [shaderDatabase.filtersAvailable objectForKey:sectionTitle];
    
    selectedRow = indexPath;
    
    //    NSLog(@"%@", [sectionFilter objectAtIndex:indexPath.row]);
    [sharedCameraManager changeToFilter:[sectionFilter objectAtIndex:indexPath.row]];
    //    NSLog(@"Filter number set to %ld", (long)indexPath.row + 1);
    
}

// Header attempt

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSString *string = @"Section";
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}

@end
