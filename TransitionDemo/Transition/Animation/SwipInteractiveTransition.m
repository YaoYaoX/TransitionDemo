//
//  SwipInteractiveTransition.m
//  TransitionDemo
//
//  Created by YY on 16/7/6.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "SwipInteractiveTransition.h"

#define kBaseHeight 400
#define kBaseWidth 200


static SwipInteractiveTransition *shareInstance = nil;

@interface SwipInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation SwipInteractiveTransition


+ (instancetype)shareInteractive{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [SwipInteractiveTransition new];
    });
    return shareInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.transitionType = TransitionTypePush;
    }
    return self;
}

- (void)wireToViewController:(UIViewController *)viewController{
    
    self.viewController = viewController;
    [self addGestureToView:viewController.view];
}

-(CGFloat)completionSpeed{
    return 1 - self.percentComplete;
}


- (void)addGestureToView:(UIView *)view{
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGes{
    
    CGPoint translation = [panGes translationInView:panGes.view.superview];
    
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan:{
        
            self->_interacting = YES;
            self.shouldComplete = NO;
            
            if (self.transitionType == TransitionTypePush) {
                [self.viewController.navigationController popViewControllerAnimated:YES];
            } else {
                [self.viewController dismissViewControllerAnimated:YES completion:nil];
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged:{
            
            CGFloat percent = 0;
            if (self.transitionType == TransitionTypePush) {
                percent = translation.x/kBaseWidth;
            } else {
                percent = translation.y/kBaseHeight;
            }
            percent = fminf(fmaxf(percent, 0.0), 1.0);
            self.shouldComplete = percent>0.5;
            NSLog(@"%@",@(percent));
            [self updateInteractiveTransition:percent];
            
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:{
        
            self->_interacting = NO;
            if (!self.shouldComplete || panGes.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}

@end
