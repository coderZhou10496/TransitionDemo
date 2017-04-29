//
//  ZJRoundAnimatedTransitioning.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/24.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ZJRoundAnimatedTransitioning.h"


@interface ZJRoundAnimatedTransitioning ()<CAAnimationDelegate>
//动画的中心坐标
@property (nonatomic,assign) CGPoint centerPoint;
//半径
@property (nonatomic,assign) CGFloat radius;
@end

@implementation ZJRoundAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
// 在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成。
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    
//    通过protocol获得动画需要的 centerPoint radius
    UIViewController *vc = self.operation == UINavigationControllerOperationPush ? fromVc : toVc;
    if([vc respondsToSelector:@selector(getTransitioningInfoWithTransitioning:)])
    {
        NSDictionary *dic = [(id <ZJTransitioningProtocol>)vc getTransitioningInfoWithTransitioning:self];
        self.centerPoint = CGPointFromString(dic[@"centerPoint"]);
        self.radius =  [dic[@"radius"] intValue];
    }
    
//    对于push pop做不同的动画
    if(self.operation == UINavigationControllerOperationPush)
    {
        UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:YES];
        CGFloat x = self.centerPoint.x;
        CGFloat y = self.centerPoint.y;
        CGFloat radius_x = MAX(x, containerView.frame.size.width - x);
        CGFloat radius_y = MAX(y, containerView.frame.size.height - y);
        CGFloat endRadius = sqrtf(pow(radius_x, 2) + pow(radius_y, 2));
        
        UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:endRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = endPath.CGPath;
        toVc.view.layer.mask = shapeLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
        animation.duration = [self transitionDuration:transitionContext];
        animation.delegate = (id)self;
        [animation setValue:transitionContext forKey:@"transitionContext"];
        [shapeLayer addAnimation:animation forKey:nil];
        
    }
    else if (self.operation == UINavigationControllerOperationPop)
    {
        [containerView insertSubview:toVc.view atIndex:0];
        UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:YES];
        CAShapeLayer *shapeLayer = (CAShapeLayer *)fromVc.view.layer.mask;
        UIBezierPath *startPath = [UIBezierPath bezierPathWithCGPath:shapeLayer.path];
        shapeLayer.path = endPath.CGPath;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
        animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
        animation.duration = [self transitionDuration:transitionContext];
        animation.delegate = (id)self;
        [animation setValue:transitionContext forKey:@"transitionContext"];
        [shapeLayer addAnimation:animation forKey:nil];

    }
    else
    {
        
    }

}
#pragma mark  CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    id<UIViewControllerContextTransitioning> contextTransition = [anim valueForKey:@"transitionContext"];
    [contextTransition completeTransition:YES];
}
@end
