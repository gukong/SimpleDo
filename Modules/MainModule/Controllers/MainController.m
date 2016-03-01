//
//  MainController.m
//  SimpleDo
//
//  Created by gukong on 15/7/25.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "MainController.h"
#import "PagesControlViewController.h"
#import "EventItem.h"

@implementation MainController

- (void)displayMainUI {
    
//    [EventItem MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
//    
//    EventItem *item1 = [EventItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//    [item1 setStartStamp:[[NSDate date] dateByAddingDays:2]];
//    [item1 setContent:@"手起刀落，两个大西瓜"];
//    [item1 setEventType:@(EventType_IM_NEM)];
//    
//    EventItem *item = [EventItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//    [item setStartStamp:[[NSDate date] dateByAddingDays:4]];
//    [item setContent:@"走在乡间的小路上，远处传来驼铃声"];
//    [item setEventType:@(EventType_NIM_EM)];
//    
//    EventItem *item2 = [EventItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//    [item2 setStartStamp:[[NSDate date] dateByAddingHours:10]];
//    [item2 setContent:@"天上的星星不说话，地上的冒菜不说话"];
//    [item2 setEventType:@(EventType_NIM_NEM)];
//    
//    EventItem *item23 = [EventItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//    [item23 setStartStamp:[[NSDate date] dateByAddingHours:15]];
//    [item23 setContent:@"风扇抓住了立柜，鸭架倒塌了里脊"];
//    [item23 setEventType:@(EventType_IM_EM)];
//    
//    EventItem *item3 = [EventItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//    [item3 setStartStamp:[[NSDate date] dateByAddingHours:10]];
//    [item3 setContent:@"阳光灿烂随悟空，英语面膜地搜图提昂"];
//    [item3 setEventType:@(EventType_IM_EM)];
//    
//    [item.managedObjectContext MR_saveToPersistentStoreAndWait];

    
    /**
     *  启动主模块
     */
    UIViewController *viewController = [PagesControlViewController pagesControl];
    [_appdelegate.window setRootViewController:viewController];
    [_appdelegate.window makeKeyAndVisible];
}

@end
