//
//  SwipInteractiveTransition.h
//  TransitionDemo
//
//  Created by YY on 16/7/6.
//  Copyright © 2016年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interacting;
@property (nonatomic, assign) TransitionType transitionType;

+ (instancetype)shareInteractive;
- (void)wireToViewController:(UIViewController *)viewController;

@end
