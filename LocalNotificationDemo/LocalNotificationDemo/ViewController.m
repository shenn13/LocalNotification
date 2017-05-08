//
//  ViewController.m
//  LocalNotificationDemo
//
//  Created by shen on 17/4/13.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "ViewController.h"
#import "LocialNotificationManager.h"

//#import <UserNotifications/UserNotifications.h>
//#define kLocalNotificationKey @"kLocalNotificationKey"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
//    用于取消本地通知
    
//    [[LocialNotificationManager manager]  cancelLocalNotificationWithKey:@"注册本地通知"];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.center = self.view.center;
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(sendLocalNotification) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)sendLocalNotification{
    
     [ [LocialNotificationManager manager] registerLocalNotification:6 key:@"注册本地通知"];
    
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        
//        
//        [self sendiOS10LocalNotification];
//        
//        
//    } else {
//        
//        [self sendiOS8LocalNotification];
//    }
}

//- (void)sendiOS10LocalNotification
//{
//    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//    content.title = @"温馨提示这是个测试";
//    content.subtitle = @"测试副标题---啦啦啦啦";
//    content.body = @"测试内容-无聊至极。。。。。。。。。。";
//    content.badge = @(1);
//    content.categoryIdentifier = kNotificationCategoryIdentifile;
//    content.userInfo = @{kLocalNotificationKey: @"iOS10推送"};
//    //推送类型
//    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
//    //固定时间推送
////    NSDateComponents *components = [[NSDateComponents alloc] init];
//    //晚上10点推送
////    components.hour = 22;
////    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
//    
//    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Test" content:content trigger:trigger];
//    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//        
//        NSLog(@"iOS 10 发送推送， error：%@", error);
//        
//    }];
//}
//
//- (void)sendiOS8LocalNotification
//{
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    //触发通知时间
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
//    //重复间隔
//    localNotification.repeatInterval = kCFCalendarUnitWeekday;
//    localNotification.timeZone = [NSTimeZone localTimeZone];
//    
//    //通知内容
//    localNotification.alertBody = @"温馨提示：你改打开我啦啦啦啦";
//    localNotification.applicationIconBadgeNumber = 1;
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    
//    //通知参数
//    localNotification.userInfo = @{kLocalNotificationKey: @"iOS8推送"};
//    
//    localNotification.category = kNotificationCategoryIdentifile;
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
