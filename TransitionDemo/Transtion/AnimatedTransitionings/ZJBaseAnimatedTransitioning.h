//
//  ZJBaseAnimatedTransitioning.h
//  TransitionDemo
//
//  Created by watchnail on 2017/4/24.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJTransitioningProtocol.h"
@import UIKit;

@interface ZJBaseAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) UINavigationControllerOperation operation;
@end
