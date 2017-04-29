//
//  ZJNavigationDelegateMediator.m
//  TransitionDemo
//
//  Created by ZJ on 17/4/26.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ZJNavigationDelegateMediator.h"
#import "ZJRoundAnimatedTransitioning.h"
#import "ZJScaleAnimatedTransitioning.h"
#import "ZJLeftSunkenAnimatedTransitioning.h"
#import "ZJRotateAnimatedTransitioning.h"
@interface ZJNavigationDelegateMediator()
@property (nonatomic,assign)UINavigationControllerOperation operation;
@property (nonatomic,strong)ZJRoundAnimatedTransitioning *roundTransitioning;
@property (nonatomic,strong)ZJScaleAnimatedTransitioning *scaleTransitioning;
@property (nonatomic,strong)ZJLeftSunkenAnimatedTransitioning *leftSunkenTransitioning;
@property (nonatomic,strong)ZJRotateAnimatedTransitioning *rotateTransitioning;
@end

@implementation ZJNavigationDelegateMediator
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    self.operation = operation;
    if(self.transitioningStyle == ZJNavigationTransitioningStyleRound)
    {
        return self.roundTransitioning;
    }
    else if (self.transitioningStyle == ZJNavigationTransitioningStyleScale)
    {
        return self.scaleTransitioning;
    }
    else if (self.transitioningStyle == ZJNavigationTransitioningStyleLeftSunken)
    {
        return self.leftSunkenTransitioning;
    }
    else if (self.transitioningStyle == ZJNavigationTransitioningStyleRotate)
    {
        return self.rotateTransitioning;
    }
    return nil;
}
-(void)setTransitioningStyle:(ZJNavigationTransitioningStyle)transitioningStyle
{
    _transitioningStyle = transitioningStyle;
}
-(ZJRoundAnimatedTransitioning *)roundTransitioning
{
    if(_roundTransitioning == nil)
    {
        _roundTransitioning = [[ZJRoundAnimatedTransitioning alloc] init];
    }
    _roundTransitioning.operation = self.operation;
    return _roundTransitioning;
}
-(ZJScaleAnimatedTransitioning *)scaleTransitioning
{
    if(_scaleTransitioning == nil)
    {
        _scaleTransitioning = [[ZJScaleAnimatedTransitioning alloc] init];
    }
    _scaleTransitioning.operation = self.operation;
    return _scaleTransitioning;
}
-(ZJLeftSunkenAnimatedTransitioning *)leftSunkenTransitioning
{
    if(_leftSunkenTransitioning == nil)
    {
        _leftSunkenTransitioning = [[ZJLeftSunkenAnimatedTransitioning alloc] init];
    }
    _leftSunkenTransitioning.operation = self.operation;
    return _leftSunkenTransitioning;
}
-(ZJRotateAnimatedTransitioning *)rotateTransitioning
{
    if(_rotateTransitioning == nil)
    {
        _rotateTransitioning = [[ZJRotateAnimatedTransitioning alloc] init];
    }
    _rotateTransitioning.operation = self.operation;
    return _rotateTransitioning;
}
@end
