//
//  ZJBaseAnimatedTransitioning.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/24.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ZJBaseAnimatedTransitioning.h"


@interface ZJBaseAnimatedTransitioning()

@end

@implementation ZJBaseAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
//    在子类中实现
    return 0;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    在子类中实现
}
@end
