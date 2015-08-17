//
//  RhombusViewLayout.m
//  PractiseDemo
//
//  Created by gukong on 15/7/15.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "RhombusViewLayout.h"

typedef NS_ENUM(int, CellType) {
    CellType_IM_EM = 0,
    CellType_IM_NEM,
    CellType_NIM_EM,
    CellType_NIM_NEM
};

@implementation RhombusViewLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    _interval = (size.width - _itemSize.width * 2 ) / 3;
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = CGSizeMake(_itemSize.width, _itemSize.width);
    switch (path.item) {
        case CellType_IM_EM:
            attributes.center = CGPointMake(_center.x, _center.y - _interval - _itemSize.width/2);
            break;
        case CellType_IM_NEM:
            attributes.center = CGPointMake(_center.x - (_interval + _itemSize.width) / 2, _center.y);
            break;
        case CellType_NIM_EM:
            attributes.center = CGPointMake(_center.x + (_interval + _itemSize.width) / 2, _center.y);
            break;
        case CellType_NIM_NEM:
            attributes.center = CGPointMake(_center.x, _center.y + _interval + _itemSize.width/2);
            break;
        default:
            break;
    }
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < _cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}
@end
