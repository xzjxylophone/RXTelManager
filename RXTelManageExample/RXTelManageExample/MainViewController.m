//
//  MainViewController.m
//  RXTelManageExample
//
//  Created by ceshi on 16/4/15.
//  Copyright © 2016年 Rush. All rights reserved.
//

#import "MainViewController.h"
#import "RXTelManager.h"
@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        sleep(2);
        
        
        [RXTelManager callWithTel:@"15901031954" errMsg:nil];
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
