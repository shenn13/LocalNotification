//
//  LocialNotificationManager.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocialNotificationManager : NSObject

+ (instancetype)manager;

/**
 *    注册本地通知
 *    @alertTime 延迟通知时间
 *    @key       用于后面取消通知
 **/
- (void)registerLocalNotification:(NSInteger)alertTime key:(NSString*)key;
/**
 *   取消某个本地推送通知
 **/
- (void)cancelLocalNotificationWithKey:(NSString *)key;

@end
