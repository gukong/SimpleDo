//
//  PagesControlViewController.h
//  SimpleDo
//
//  Created by gukong on 15/7/27.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseViewController.h"

@class PageNavigationBar;

@interface PagesControlViewController : BaseViewController

/**
 *  Don't call [init] directly
 *
 *  Call [PagesControlViewController pagesControl] instead
 */
+ (id)pagesControl;

@end
