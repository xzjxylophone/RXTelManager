//
//  RXTelManager.h
//  RXTelManagerExample
//
//  Created by ceshi on 16/4/15.
//  Copyright © 2016年 Rush. All rights reserved.
//

#import <Foundation/Foundation.h>

// default is nil, not @""
extern const NSString *kRXTelManager_AlertViewTitle_AttributeName;
// default is @"拨打电话"
extern const NSString *kRXTelManager_AlertViewOK_AttributeName;
// default is @"取消"
extern const NSString *kRXTelManager_AlertViewCancel_AttributeName;
// default is 无法拨打电话:tel
extern const NSString *kRXTelManager_ErrorMsg_AttributeName;



@interface RXTelManager : NSObject



+ (void)callWithTel:(NSString *)tel errMsg:(NSString **)errMsg;


+ (void)setManagerAttributes:(NSDictionary *)attributes;



#pragma mark - Signal Model
+ (RXTelManager *)sharedInstance;






@end
