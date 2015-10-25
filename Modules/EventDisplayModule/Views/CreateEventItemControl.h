//
//  CreateEventItemControl.h
//  SimpleDo
//
//  Created by gukong on 15/9/6.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventItemControl : UIControl

@property (nonatomic, strong) UIImageView *itemIcon;
@property (nonatomic, strong) UILabel *itemContentLabel;

- (void)updateContent:(NSString *)content;

@end
