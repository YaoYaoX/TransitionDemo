//
//  ViewController.m
//  TransitionDemo
//
//  Created by YY on 16/7/5.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "ViewController.h"
#import "FromViewController.h"
#import "InteractiveTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)animationTest:(id)sender {
    
    FromViewController *fromVC = [[FromViewController alloc]init];
    [self.navigationController pushViewController:fromVC animated:YES];
}

- (IBAction)InteractiveTest:(id)sender {
    
    InteractiveTestViewController *fromVC = [[InteractiveTestViewController alloc]init];
    [self.navigationController pushViewController:fromVC animated:YES];
}

@end
