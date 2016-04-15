//
//  RXTelManager.m
//  RXTelManageExample
//
//  Created by ceshi on 16/4/15.
//  Copyright © 2016年 Rush. All rights reserved.
//

#import "RXTelManager.h"
#import <UIKit/UIKit.h>
@interface RXTelManager () <UIAlertViewDelegate>

@property (nonatomic, strong) NSURL *url;

@end


@implementation RXTelManager


#pragma mark - Public
+ (void)callWithTel:(NSString *)tel errMsg:(NSString **)errMsg
{
    NSString *telString = [NSString stringWithFormat:@"tel://%@", tel];
    NSURL *url = [NSURL URLWithString:telString];
    if (url == nil) {
        NSString *tmpString =  [NSString stringWithString:[telString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        url = [NSURL URLWithString:tmpString];
    }
    RXTelManager *tm = [RXTelManager sharedInstance];
    tm.url = url;
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:tel delegate:tm cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        [av show];
    } else {
        NSString *msg = [NSString stringWithFormat:@"无法拨打电话:%@", tel];
        if (errMsg != nil) {
            *errMsg = msg;
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
    NSURL *url = self.url;
    self.url = nil;
    [[UIApplication sharedApplication] openURL:url];
}



#pragma mark - Constructor And Destructor
- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}


#pragma mark - Signal Model
+ (RXTelManager *)sharedInstance
{
    static RXTelManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^(void) {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
