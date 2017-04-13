//
//  AppDelegate.m
//  LocalNotificationDemo
//
//  Created by shen on 17/4/13.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "AppDelegate.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerLocalNotification];
    
    return YES;
}

- (void)registerLocalNotification
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
        [self registeriOS10LocalNotification];
        
    } else {
        
        [self registeriOS8LocalNotification];
    }
}

- (void)registeriOS10LocalNotification
{
    //iOS10特有
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNNotificationCategory *catetory = [UNNotificationCategory categoryWithIdentifier:kNotificationCategoryIdentifile actions:@[] intentIdentifiers:@[kNotificationActionIdentifileStar, kNotificationActionIdentifileComment] options:UNNotificationCategoryOptionNone];
    
    
    [center setNotificationCategories:[NSSet setWithObject:catetory]];
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
            //用户点击允许
            NSLog(@"注册成功");
            
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"%@", settings);
            }];
        } else {
            //用户点击不允许
            NSLog(@"注册失败");
        }
    }];
}

- (void)registeriOS8LocalNotification
{
    //创建消息上面要添加的动作（iOS9才支持）
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = kNotificationActionIdentifileStar;
    action1.activationMode = UIUserNotificationActivationModeBackground;
    action1.authenticationRequired = YES;
    action1.destructive = NO;
    
    //创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    //这组动作的唯一标示
    category.identifier = kNotificationCategoryIdentifile;
    //最多支持两个，如果添加更多的话，后面的将被忽略
    [category setActions:@[action1] forContext:(UIUserNotificationActionContextMinimal)];
    //创建UIUserNotificationSettings，并设置消息的显示类类型
    
    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObject:category]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
}

#pragma mark - iOS10 接收推送的两个方法
/**
 本地和远程推送合为一个，通过 response.notification.request.trigger 来区分
 1.UNPushNotificationTrigger （远程通知） 远程推送的通知类型
 
 2.UNTimeIntervalNotificationTrigger （本地通知） 一定时间之后，重复或者不重复推送通知。我们可以设置timeInterval（时间间隔）和repeats（是否重复）。
 
 3.UNCalendarNotificationTrigger（本地通知） 一定日期之后，重复或者不重复推送通知 例如，你每天8点推送一个通知，只要dateComponents为8，如果你想每天8点都推送这个通知，只要repeats为YES就可以了。
 
 4.UNLocationNotificationTrigger （本地通知）地理位置的一种通知，
 当用户进入或离开一个地理区域来通知。在CLRegion标识符必须是唯一的。因为如果相同的标识符来标识不同区域的UNNotificationRequests，会导致不确定的行为。
 */
//接收到通知的事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    NSNumber *badge = content.badge;
    NSString *body = content.body;
    NSString *title = content.title;
    NSString *subTitle = content.subtitle;
    //    UNNotificationSound *sound = content.sound;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
    } else {
        
        // 判断为本地通知
        NSLog(@"iOS10 应用在前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nuserInfo：%@\\\\n}", body, title, subTitle, badge, userInfo);
        
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    NSNumber *badge = content.badge;
    NSString *body = content.body;
    NSString *title = content.title;
    NSString *subTitle = content.subtitle;
    UNNotificationSound *sound = content.sound;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
    } else {
        // 判断为本地通知
        NSLog(@"iOS10 应用在后台点击推送消息收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}", body, title, subTitle, badge, sound, userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

#pragma mark - iOS9 及之前方法
// (iOS9及之前)本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge -= notification.applicationIconBadgeNumber;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
