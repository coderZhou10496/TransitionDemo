//
//  ZJLeftSunkenAnimatedTransitioning.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/26.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ZJLeftSunkenAnimatedTransitioning.h"

@interface ZJSnapshot : NSObject

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) UIView *snapshotView;

@end

@implementation ZJSnapshot
@end


@interface ZJLeftSunkenAnimatedTransitioning()

@property (nonatomic, strong) NSMutableArray *snapshots;

@end

@implementation ZJLeftSunkenAnimatedTransitioning
- (NSMutableArray *)snapshots {
    if (!_snapshots) {
        _snapshots = [NSMutableArray array];
    }
    return _snapshots;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 取window得第一个subview，用于截屏操作
    // baseView 在界面上看起来相当于 (fromView + 导航栏)视图
    UIView *baseView = [[keyWindow subviews] firstObject];

    // 这个tag用来标记 阴影view ，即下面加在截屏view上的 maskView
    NSInteger tag = 6789;
    
    if (self.operation == UINavigationControllerOperationPush)
    {
        
        UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = baseView.frame;
        
//        过渡动画的阴影视图
        UIView *maskView = [[UIView alloc] initWithFrame:snapshotView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0;
        maskView.tag = tag;
        [snapshotView addSubview:maskView];
        
        [containerView addSubview:toView];
        [keyWindow addSubview:snapshotView ];
        [keyWindow bringSubviewToFront:baseView];
        
        CGRect originalFrame = baseView.frame;
        CGRect newFrame = baseView.frame;
        newFrame.origin.x = newFrame.origin.x + newFrame.size.width;
        baseView.frame = newFrame;

        // 用于截屏view snapshotView的缩放 位移动画
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/750;
        transform = CATransform3DTranslate(transform, 0, 0, -40);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            baseView.frame = originalFrame;
            snapshotView.layer.transform = transform;
            maskView.alpha = 0.8;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            
            // 将截图和截图所对应的fromVC储存起来，放到数组里
            ZJSnapshot *snapshot = [[ZJSnapshot alloc] init];
            snapshot.snapshotView = snapshotView;
            snapshot.viewController = fromVC;
            [self.snapshots addObject:snapshot];
            
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            
            
        }];
    }
    else if (self.operation == UINavigationControllerOperationPop)
    {
        // 从数组找到 toVC 所对应的 ZJSnapshot 对象
        ZJSnapshot *result = nil;
        for (int i = (int)self.snapshots.count - 1; i >= 0; i--)
        {
            ZJSnapshot *snapshot = [self.snapshots objectAtIndex:i];
            if (snapshot.viewController == toVC) {
                result = snapshot;
                break;
            }
        }
        // 从数组中移除此对象及角标后面的对象
        if (result)
        {
            NSUInteger index = [self.snapshots indexOfObject:result];
            [self.snapshots removeObjectsInRange:NSMakeRange(index, self.snapshots.count - index)];
        }
        
        if (result) {
            
            
            UIView *snapshotView = result.snapshotView;
            UIView *maskView = [snapshotView viewWithTag:tag];
            
            [keyWindow addSubview:snapshotView];
            [keyWindow bringSubviewToFront:baseView];
            

            CGRect originalFrame = baseView.frame;
            CGRect newFrame = baseView.frame;
            newFrame.origin.x = newFrame.origin.x + newFrame.size.width;
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                maskView.alpha = 0.0;
                
                // 将 snapshotView 还原到最初状态的动画
                snapshotView.layer.transform = CATransform3DIdentity;
                
                // 将fromView位移到屏幕右边的动画
                baseView.frame = newFrame;
            } completion:^(BOOL finished) {
                baseView.frame = originalFrame;
                [containerView addSubview:toView];
                [snapshotView removeFromSuperview];
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
    }
    else
    {
        
    }

}
@end
