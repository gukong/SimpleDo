//
//  AppEnum.h
//  SimpleDo
//
//  Created by gukong on 15/7/19.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#ifndef SimpleDo_AppEnum_h
#define SimpleDo_AppEnum_h

typedef NS_OPTIONS(NSInteger, EventType) {
    EventType_IM_EM = 0,
    EventType_IM_NEM,
    EventType_NIM_EM,
    EventType_NIM_NEM,
    
    EventType_SUM
};

#endif
