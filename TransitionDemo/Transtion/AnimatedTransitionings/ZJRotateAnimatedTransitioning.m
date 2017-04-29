//
//  ZJRotateAnimatedTransitioning.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/27.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ZJRotateAnimatedTransitioning.h"

@interface ZJRotateAnimatedTransitioning ()
@end

@implementation ZJRotateAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrameForToVC = [transitionContext finalFrameForViewController:toVC];
    toView.frame = finalFrameForToVC;
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 取window得第一个subview，用于截屏操作
    // baseView 在界面上看起来相当于 (fromView + 导航栏)视图
    UIView *baseView = [[keyWindow subviews] firstObject];
    
    if(self.operation == UINavigationControllerOperationPush)
    {
        UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = baseView.frame;
        
        [keyWindow addSubview:snapshotView];
        [keyWindow bringSubviewToFront:baseView];
        
        [containerView addSubview:toView];
        
//        设置锚点
//        锚点设置完之后必须要更新一下坐标
        baseView.layer.anchorPoint =  CGPointMake(0.5, 2.0);
        baseView.frame = finalFrameForToVC;
//        旋转45度
        baseView.transform =CGAffineTransformMakeRotation(M_PI_4);
        
//        UIViewAnimationOptionCurveEaseOut  由快到慢
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
//            将视图还原的动画
            baseView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
//            锚点还原
            baseView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            baseView.frame = finalFrameForToVC;
//            移除截屏视图
            [snapshotView removeFromSuperview];
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    else if (self.operation == UINavigationControllerOperationPop)
    {
        [containerView insertSubview:toView belowSubview:fromView];
        toView.frame = finalFrameForToVC;
        
        UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = baseView.frame;
        [keyWindow addSubview:snapshotView];
        
//        将fromView 隐藏，进行动画的是截屏View:snapshotView
        fromView.hidden = YES;
        
        snapshotView.layer.anchorPoint =  CGPointMake(0.5, 2);
        snapshotView.frame = finalFrameForToVC;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            snapshotView.transform = CGAffineTransformMakeRotation(M_PI_4 * 3/4);
            baseView.frame = finalFrameForToVC;
            
        } completion:^(BOOL finished) {
            
            [snapshotView removeFromSuperview];
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    
}
@end
