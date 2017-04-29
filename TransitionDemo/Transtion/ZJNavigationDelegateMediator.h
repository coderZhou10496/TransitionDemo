//
//  ZJNavigationDelegateMediator.h
//  TransitionDemo
//
//  Created by ZJ on 17/4/26.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#import "UINavigationController+ZJTransitioning.h"


@interface ZJNavigationDelegateMediator : NSObject<UINavigationControllerDelegate>

@property (nonatomic,assign) ZJNavigationTransitioningStyle transitioningStyle;

@end
