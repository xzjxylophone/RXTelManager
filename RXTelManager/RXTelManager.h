//
//  RXTelManager.h
//  RXTelManageExample
//
//  Created by ceshi on 16/4/15.
//  Copyright © 2016年 Rush. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface RXTelManager : NSObject



+ (void)callWithTel:(NSString *)tel errMsg:(NSString **)errMsg;





#pragma mark - Signal Model
+ (RXTelManager *)sharedInstance;






@end
