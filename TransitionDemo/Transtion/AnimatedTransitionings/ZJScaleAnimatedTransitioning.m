//
//  ZJScaleAnimatedTransitioning.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/25.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ZJScaleAnimatedTransitioning.h"

@implementation ZJScaleAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    //    在子类中实现
    return 0.35;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrameForToVC = [transitionContext finalFrameForViewController:toVC];
    toView.frame = finalFrameForToVC;
    [toView layoutIfNeeded];
    
//    得到 fromImageView toImageView
    UIImageView *fromImageView = nil;
    UIImageView *toImageView = nil;
    CGRect fromRect = CGRectZero ;
    CGRect ToRect = CGRectZero;
    if([fromVC respondsToSelector:@selector(getTransitioningInfoWithTransitioning:)])
    {
        NSDictionary *dic = [(id <ZJTransitioningProtocol>)fromVC getTransitioningInfoWithTransitioning:self];
        fromImageView = dic[@"imageView"];
        fromRect = CGRectFromString(dic[@"frame"]);
    }
    if([toVC respondsToSelector:@selector(getTransitioningInfoWithTransitioning:)])
    {
        NSDictionary *dic = [(id <ZJTransitioningProtocol>)toVC getTransitioningInfoWithTransitioning:self];
        toImageView = dic[@"imageView"];
        ToRect = CGRectFromString(dic[@"frame"]);
    }
    
//    在 fromView 与 toView 各加上一层阴影 ，动画的过程中改变 alpha 值，动画结束后移除阴影
    CGFloat maskViewAlpha = 0.2;
    UIView *maskViewForFromView = [[UIView alloc] init];
    maskViewForFromView.backgroundColor = [UIColor blackColor];
    maskViewForFromView.frame = fromView.bounds;
    [fromView addSubview:maskViewForFromView];
    maskViewForFromView.alpha = 0.0;
    
    UIView *maskViewForToView = [[UIView alloc] init];
    maskViewForToView.backgroundColor = [UIColor blackColor];
    maskViewForToView.frame = toView.bounds;
    [toView addSubview:maskViewForToView];
    maskViewForToView.alpha = maskViewAlpha;
    
    
//    为了动画效果，先设置 toView.frame
    if (self.operation == UINavigationControllerOperationPush)
    {
        CGRect frame = toView.frame;
        frame.origin.x = fromView.frame.origin.x + fromView.frame.size.width;
        toView.frame = frame;
        [containerView addSubview:toView];
    }
    else if (self.operation == UINavigationControllerOperationPop)
    {
        CGRect frame = toView.frame;
        frame.origin.x = fromView.frame.origin.x - frame.size.width / 3.0;
        toView.frame = frame;
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
//    这个过渡的imageView 加在 window 上 ，用imageView的坐标的变化实现动画效果，动画结束后移除此过渡imageView
    UIImageView *imageView = [self copyOfImageView:toImageView];
    imageView.frame = fromRect;
    [[UIApplication sharedApplication].keyWindow addSubview:imageView];

//    先将原来的fromImageView隐藏
    fromImageView.hidden = YES;
    toImageView.hidden = YES;
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations: ^{
        maskViewForFromView.alpha = maskViewAlpha;
        maskViewForToView.alpha = 0.0;
        
        toView.frame = finalFrameForToVC;
        if (self.operation == UINavigationControllerOperationPush)
        {
            CGRect frame = fromView.frame;
            frame.origin.x = frame.origin.x - frame.size.width / 3.0;
            fromView.frame = frame;
        }
        else if (self.operation == UINavigationControllerOperationPop)
        {
            CGRect frame = fromView.frame;
            frame.origin.x = frame.origin.x + frame.size.width;
            fromView.frame = frame;
        }
        imageView.frame = ToRect;
    } completion:^(BOOL finished) {
        [maskViewForFromView removeFromSuperview];
        [maskViewForToView removeFromSuperview];
    
        fromImageView.hidden = NO;
        toImageView.hidden = NO;
        [imageView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
- (UIImageView *)copyOfImageView:(UIImageView *)imageView {
    UIImageView *dummyImageView = [[UIImageView alloc] init];
    dummyImageView.contentMode = imageView.contentMode;
    dummyImageView.image = imageView.image;
    dummyImageView.clipsToBounds = imageView.clipsToBounds;
    return dummyImageView;
}
@end
