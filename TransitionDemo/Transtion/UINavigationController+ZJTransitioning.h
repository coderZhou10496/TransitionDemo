//
//  UINavigationController+ZJTransitioning.h
//  TransitionDemo
//
//  Created by watchnail on 2017/4/24.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZJNavigationTransitioningStyle){
    ZJNavigationTransitioningStyleSystem = 0,
    ZJNavigationTransitioningStyleRound,
    ZJNavigationTransitioningStyleScale,
    ZJNavigationTransitioningStyleLeftSunken,
    ZJNavigationTransitioningStyleRotate
};

@interface UINavigationController (ZJTransitioning)

@property (nonatomic,assign) ZJNavigationTransitioningStyle transitioningStyle;
@end
