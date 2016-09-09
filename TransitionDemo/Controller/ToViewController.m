//
//  ToViewController.m
//  TranslationDemo
//
//  Created by YY on 16/7/5.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "ToViewController.h"

@interface ToViewController ()

@end

@implementation ToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"To VC";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT-50, 100, 50)];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:btn];
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dismissBtnClicked{
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
