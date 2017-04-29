//
//  UINavigationController+ZJTransitioning.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/24.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "UINavigationController+ZJTransitioning.h"
#import "ZJRoundAnimatedTransitioning.h"
#import "ZJScaleAnimatedTransitioning.h"
#import "ZJLeftSunkenAnimatedTransitioning.h"
#import <objc/runtime.h>
#import "ZJNavigationDelegateMediator.h"

static char ZJTransitioningMediator_key;

@interface UINavigationController ()
@property (nonatomic,strong)ZJNavigationDelegateMediator *mediator;
@end

@implementation UINavigationController (ZJTransitioning)
-(void)viewDidLoad
{
//    将delegate 设置为 ZJNavigationDelegateMediator 对象，在 ZJNavigationDelegateMediator 类里实现
//    UINavigationControllerDelegate的方法
    self.delegate = self.mediator;
}
-(ZJNavigationTransitioningStyle)transitioningStyle
{
    return self.mediator.transitioningStyle;
}
-(void)setTransitioningStyle:(ZJNavigationTransitioningStyle)transitioningStyle
{
    self.mediator.transitioningStyle = transitioningStyle;
}
-(ZJNavigationDelegateMediator *)mediator
{
    ZJNavigationDelegateMediator *mediator = objc_getAssociatedObject(self, &ZJTransitioningMediator_key);
    if(mediator == nil)
    {
        mediator = [[ZJNavigationDelegateMediator alloc] init];
        self.mediator = mediator;
    }
    return mediator;
    
}
-(void)setMediator:(ZJNavigationDelegateMediator *)mediator
{
    objc_setAssociatedObject(self, &ZJTransitioningMediator_key, mediator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
@end
