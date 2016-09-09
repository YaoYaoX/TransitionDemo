//
//  InteractiveTestViewController.m
//  TransitionDemo
//
//  Created by YY on 16/7/6.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "InteractiveTestViewController.h"
#import "SwipInteractiveTransition.h"
#import "ToViewController.h"

@interface InteractiveTestViewController ()

@property (nonatomic, strong) SwipInteractiveTransition *interaction;

@end

@implementation InteractiveTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Interaction Test";
}

/** 重写方法：跳转下一页 */
- (void)toBtnClicked{
    
    ToViewController *toVC =  [[ToViewController alloc] init];
    [self.interaction wireToViewController:toVC];
    
    
    // 1.更换动画过渡代理
    if (self.push) {
        // push时修改navigationController的代理
        self.navigationController.delegate = self;
        self.interaction.transitionType = TransitionTypePush;
        [self.navigationController pushViewController:toVC animated:YES];
    } else {
        // present时修改transitioningDelegate的代理
        toVC.transitioningDelegate = self;
        self.interaction.transitionType = TransitionTypeModal;
        [self presentViewController:toVC animated:YES completion:nil];
    }
}

#pragma mark - interaction

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
        
    return self.interaction.interacting? self.interaction : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    return self.interaction.interacting? self.interaction : nil;
}

#pragma mark - getter

-(SwipInteractiveTransition *)interaction{
    if (!_interaction) {
        _interaction = [[SwipInteractiveTransition alloc] init];
    }
    return _interaction;
}

@end
