//
//  ImageViewController.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/25.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ImageViewController.h"
#import "ZJTransitioningProtocol.h"
@interface ImageViewController ()<ZJTransitioningProtocol>
@property(nonatomic,strong)UIImageView *bigImageView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ImageViewController";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.center = self.view.center;
    imageView.bounds = CGRectMake(0, 0, 200, 200);
    imageView.image = [UIImage imageNamed:@"leaf.jpg"];
    [self.view addSubview:imageView];
    self.bigImageView = imageView;
}
-(NSDictionary *)getTransitioningInfoWithTransitioning:(id <UIViewControllerAnimatedTransitioning>)transitioning
{
    CGRect newRect = [self.bigImageView.superview convertRect:self.bigImageView.frame toView:[UIApplication sharedApplication].keyWindow];
    return @{@"imageView":self.bigImageView,
             @"frame":NSStringFromCGRect(newRect)};
}
@end
