//
//  MainController.m
//  SimpleDo
//
//  Created by gukong on 15/7/25.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "MainController.h"
#import "PagesControlViewController.h"

@implementation MainController

- (void)displayMainUI {
    
    /**
     *  启动主模块
     */
    UIViewController *viewController = [PagesControlViewController pagesControl];
    [_appdelegate.window setRootViewController:viewController];
    [_appdelegate.window makeKeyAndVisible];
}

@end
