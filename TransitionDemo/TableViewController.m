//
//  TableViewController.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/19.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "TableViewController.h"
#import "UINavigationController+ZJTransitioning.h"
#import "ResultViewController.h"
#import "ZJTransitioningProtocol.h"
#import "ZJRoundAnimatedTransitioning.h"
#import "ZJScaleAnimatedTransitioning.h"
#import "ImageViewController.h"
@interface TableViewController ()<ZJTransitioningProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *roundImageView;

@property (weak, nonatomic) IBOutlet UIImageView *leafImageView;

@property (nonatomic,strong)NSArray *styleArray;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.styleArray = @[@(ZJNavigationTransitioningStyleSystem),@(ZJNavigationTransitioningStyleRound),@(ZJNavigationTransitioningStyleScale),@(ZJNavigationTransitioningStyleLeftSunken),@(ZJNavigationTransitioningStyleRotate)];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        ImageViewController *controller = [[ImageViewController alloc] init];
        self.navigationController.transitioningStyle = ZJNavigationTransitioningStyleScale;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        ResultViewController *controller = [[ResultViewController alloc] init];
        self.navigationController.transitioningStyle = [self.styleArray[indexPath.row] integerValue];
        [self.navigationController pushViewController:controller animated:YES];
    }    
}
-(NSDictionary *)getTransitioningInfoWithTransitioning:(id <UIViewControllerAnimatedTransitioning>)transitioning
{
    if([transitioning isKindOfClass:[ZJRoundAnimatedTransitioning class]])
    {
        CGPoint newpoint = [self.roundImageView.superview convertPoint:self.roundImageView.center toView:[UIApplication sharedApplication].keyWindow];
        return @{@"centerPoint":NSStringFromCGPoint(newpoint),
                 @"radius":@((int)self.roundImageView.frame.size.width/2)};
    }
    if([transitioning isKindOfClass:[ZJScaleAnimatedTransitioning class]])
    {
        CGRect newRect = [self.leafImageView.superview.superview convertRect:self.leafImageView.frame toView:[UIApplication sharedApplication].keyWindow];
        return @{@"imageView":self.leafImageView,
                 @"frame":NSStringFromCGRect(newRect)
                 };
    }
    return nil;
    
}

@end
