//
//  BaseManagedObjectStore.m
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseManagedObjectStore.h"

@implementation BaseManagedObjectStore

+ (NSArray *)fetchObjectsWithRequest:(NSFetchRequest *)fetchRequest {
    NSError *error = nil;
    NSArray *objects = [[NSManagedObjectContext MR_defaultContext] executeFetchRequest:fetchRequest error:&error];
    if (error) {
        objects = nil;
    }
    return objects;
}

+ (NSManagedObject *)createEntityWithName:(NSString *)name {
    NSEntityDescription *employeeEntity = [NSEntityDescription entityForName:name
                                                      inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    NSManagedObject *item = [[NSManagedObject alloc] initWithEntity:employeeEntity
                               insertIntoManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    
    return item;
}

@end
