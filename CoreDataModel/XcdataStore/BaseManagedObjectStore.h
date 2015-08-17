//
//  BaseManagedObjectStore.h
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseManagedObjectStore : NSObject

+ (NSArray *)fetchObjectsWithRequest:(NSFetchRequest *)fetchRequest;

+ (NSManagedObject *)createEntityWithName:(NSString *)name;

@end
