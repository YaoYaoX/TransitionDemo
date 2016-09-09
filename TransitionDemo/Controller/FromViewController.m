//
//  FromViewController.m
//  TranslationDemo
//
//  Created by YY on 16/7/5.
//  Copyright © 2016年 YY. All rights reserved.
//  查看注释的1、2过程

#import "FromViewController.h"
#import "ToViewController.h"
#import "PresentAnimation.h"
#import "PushPopAnimation.h"

@interface FromViewController ()

@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.push = NO;
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"From VC";
    
    CGFloat padding = 10;
    
    UIButton *toBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100-padding, SCREEN_HEIGHT-50, 100, 50)];
    toBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:toBtn];
    [toBtn setTitle:@"next" forState:UIControlStateNormal];
    [toBtn addTarget:self action:@selector(toBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UISwitch *pullSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(padding, SCREEN_HEIGHT-40, 50, 30)];
    pullSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    pullSwitch.on = YES;
    [self.view addSubview:pullSwitch];
    [pullSwitch addTarget:self action:@selector(pullSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(padding, CGRectGetMinY(pullSwitch.frame)-22, 100, 21)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.text = @"  modal?";
    [self.view addSubview:label];
}

#pragma mark - action

- (void)pullSwitchChanged:(UISwitch *)switcher{
    self.push = !switcher.on;
}

/** 跳转下一页 */
- (void)toBtnClicked{
    
    ToViewController *toVC =  [[ToViewController alloc] init];
    
    // 1.更换动画过渡代理
    if (self.push) {
        // push时修改navigationController的代理
        self.navigationController.delegate = self;
        [self.navigationController pushViewController:toVC animated:YES];
    } else {
        // present时修改transitioningDelegate的代理
        toVC.transitioningDelegate = self;
        [self presentViewController:toVC animated:YES completion:nil];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

// 2.modal方式：指定自定义的动画代理
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    // present的时候的动画
    return [PresentAnimation new];
    
    // nil代表使用默认过渡效果
    //return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    // dismiss的时候的动画
    return [PresentAnimation new];
    
    // nil代表使用默认过渡效果
    //return nil;
}

#pragma mark - UINavigationControllerDelegate

// 2.push/pop方式：指定自定义的动画代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    // 设置自定义动画
    id<UIViewControllerAnimatedTransitioning> animation = [PushPopAnimation new];//使用默认效果
    
    // 3.以便在pop到当前页面的时候恢复默认转场效果
    if (toVC == self) {
        self.navigationController.delegate = nil;
    }
    
    return animation;
}
@end
