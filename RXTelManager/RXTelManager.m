//
//  RXTelManager.m
//  RXTelManagerExample
//
//  Created by ceshi on 16/4/15.
//  Copyright © 2016年 Rush. All rights reserved.
//

#import "RXTelManager.h"
#import <UIKit/UIKit.h>



// default is nil, not @""
const NSString *kRXTelManager_AlertViewTitle_AttributeName = @"kRXTelManager_AlertViewTitle_AttributeName";
// default is @"拨打电话"
const NSString *kRXTelManager_AlertViewOK_AttributeName = @"kRXTelManager_AlertViewOK_AttributeName";
// default is @"取消"
const NSString *kRXTelManager_AlertViewCancel_AttributeName = @"kRXTelManager_AlertViewCancel_AttributeName";
// default is 无法拨打电话:tel
const NSString *kRXTelManager_ErrorMsg_AttributeName = @"kRXTelManager_ErrorMsg_AttributeName";


@interface RXTelManager () <UIAlertViewDelegate>

@property (nonatomic, strong) NSURL *url;


@property (nonatomic, strong) NSDictionary *defaultAttribute;
@property (nonatomic, strong) NSMutableDictionary *currentAttribute;

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
        
        NSString *title = nil;
        id idTitle = tm.currentAttribute[kRXTelManager_AlertViewTitle_AttributeName];
        if ([idTitle isKindOfClass:[NSNull class]]) {
            title = nil;
        } else {
            title = idTitle;
        }
        NSString *okStr = tm.currentAttribute[kRXTelManager_AlertViewOK_AttributeName];
        NSString *cancelStr = tm.currentAttribute[kRXTelManager_AlertViewCancel_AttributeName];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:tel delegate:tm cancelButtonTitle:cancelStr otherButtonTitles:okStr, nil];
        [av show];
    } else {
        NSString *msg = @"";
        id idErrMsg = tm.currentAttribute[kRXTelManager_ErrorMsg_AttributeName];
        if ([idErrMsg isKindOfClass:[NSNull class]]) {
            msg = [NSString stringWithFormat:@"无法拨打电话:%@", tel];
        } else {
            msg = idErrMsg;
        }
        if (errMsg != nil) {
            *errMsg = msg;
        }
    }
}
+ (void)setManagerAttributes:(NSDictionary *)attributes
{
    RXTelManager *tm = [RXTelManager sharedInstance];
    tm.currentAttribute = [NSMutableDictionary dictionaryWithDictionary:tm.defaultAttribute];
    for (NSString *key in attributes.allKeys) {
        [tm.currentAttribute setValue:attributes[key] forKey:key];
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
        
        NSDictionary *defaultDic = @{kRXTelManager_AlertViewTitle_AttributeName:[NSNull null],
                                     kRXTelManager_AlertViewOK_AttributeName:@"拨打电话",
                                     kRXTelManager_AlertViewCancel_AttributeName:@"取消",
                                     kRXTelManager_ErrorMsg_AttributeName:[NSNull null]};
        self.defaultAttribute = defaultDic;
        self.currentAttribute = [NSMutableDictionary dictionaryWithDictionary:defaultDic];
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
