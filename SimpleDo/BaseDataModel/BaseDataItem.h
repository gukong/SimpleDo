//
//  BaseDataItem.h
//  SimpleDo
//
//  Created by gukong on 16/3/1.
//  Copyright © 2016年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDataItem : NSObject
@property (nonatomic, strong) NSString  *itemName;
@property (nonatomic, strong) NSString  *placehodler;
@property (nonatomic, strong) NSString  *itemValue;
@property (nonatomic, strong) NSArray   *itemArray;
@property (nonatomic, assign) BOOL      *valueChanged;
@property (nonatomic, assign) NSInteger *row;
@end
