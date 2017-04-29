//
//  ZJTransitioningProtocol.h
//  TransitionDemo
//
//  Created by ZJ on 17/4/26.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

/**
 此协议是为了得到push方式为 ZJNavigationTransitioningStyleRound 和 ZJNavigationTransitioningStyleScale 的图片的相关信息
 */
@protocol ZJTransitioningProtocol <NSObject>
-(NSDictionary *)getTransitioningInfoWithTransitioning:(id <UIViewControllerAnimatedTransitioning>)transitioning;
@end
