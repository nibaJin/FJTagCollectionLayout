//
//  FJTagCollectionLayout.m
//  CollectionView
//
//  Created by fujin on 16/1/12.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "FJTagCollectionLayout.h"

@interface FJTagCollectionLayout ()

@property (nonatomic, assign) CGPoint endPoint; // 记录最后一个的位置

@property (nonatomic, assign) NSInteger count;  // section * 有多少count

@property (nonatomic, assign) BOOL isUpdateRow; // 是否要更新上一行的cell

@property (nonatomic, assign) NSInteger beginIndex; // 行开始的index

@property (nonatomic, assign) NSInteger endIndex; // 行结束的index

@property (nonatomic, strong) NSMutableDictionary *attriCacheDic; //attributes cache
@end

@implementation FJTagCollectionLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        // default layout
        _sectionInset = UIEdgeInsetsZero;
        _lineSpacing = 10;
        _itemSpacing = 10;
        _itemHeigh = 30;
        _layoutAligned = FJTagLayoutAlignedLeft;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
 /* default */
    _endPoint = CGPointZero;
    
    // 预先布局 并 缓存
    [self configAttributes];
}

- (void)configAttributes
{
    _attriCacheDic = [NSMutableDictionary new];
    
    NSInteger sectionNum = [self.collectionView numberOfSections];
    
    for (NSInteger i = 0; i < sectionNum; i ++) {
        _count = [self.collectionView numberOfItemsInSection:i];
        
        // header
        UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [_attriCacheDic setObject:headerAttr forKey:[NSString stringWithFormat:@"%ld_header",i]];
        
        // items
        NSMutableArray *itemsAttr = [NSMutableArray new];
        _beginIndex = 0;
        _endIndex = 0;
        _isUpdateRow = NO;
        for (NSInteger j = 0; j < _count; j++) {
            UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            [itemsAttr addObject:attrs];
            
            /* 对齐形式  */
            if (_layoutAligned == FJTagLayoutAlignedLeft) {
                // 居左
                continue ;
            }else{
                if (_isUpdateRow) {
                    UICollectionViewLayoutAttributes *beginAttr = itemsAttr[_beginIndex];
                    UICollectionViewLayoutAttributes *endAttr = itemsAttr[_endIndex];
                    
                    CGFloat offsetX;
                    if (_layoutAligned == FJTagLayoutAlignedMiddle) {
                        offsetX = (beginAttr.frame.origin.x - (CGRectGetWidth(self.collectionView.frame) - endAttr.frame.origin.x - endAttr.frame.size.width))*0.5; // 居中
                    }else{
                        offsetX = _sectionInset.right - (CGRectGetWidth(self.collectionView.frame) - endAttr.frame.origin.x - endAttr.frame.size.width); // 居右
                    }
                    
                    for (NSInteger i = _beginIndex; i <= _endIndex; i ++ ) {
                        UICollectionViewLayoutAttributes *updateAttr = itemsAttr[i];
                        updateAttr.frame = CGRectMake(updateAttr.frame.origin.x - offsetX, updateAttr.frame.origin.y, updateAttr.frame.size.width, updateAttr.frame.size.height);
                    }
                    
                    _beginIndex = _endIndex + 1;
                    // 最后一行只有一个 特殊处理
                    if (_beginIndex == _count-1) {
                        _endIndex = _endIndex + 1;
                        UICollectionViewLayoutAttributes *lastAttr = itemsAttr[_endIndex];
                        
                        CGFloat offsetX;
                        if (_layoutAligned == FJTagLayoutAlignedMiddle) {
                            offsetX = (lastAttr.frame.origin.x - (CGRectGetWidth(self.collectionView.frame) - lastAttr.frame.origin.x - lastAttr.frame.size.width))*0.5; // 居中
                            
                        }else{
                            offsetX = _sectionInset.right - (CGRectGetWidth(self.collectionView.frame) - lastAttr.frame.origin.x - lastAttr.frame.size.width); // 居右
                        }
                        lastAttr.frame = CGRectMake(lastAttr.frame.origin.x - offsetX, lastAttr.frame.origin.y, lastAttr.frame.size.width, lastAttr.frame.size.height);
                    }
                }
            }
        }
        
        [_attriCacheDic setObject:itemsAttr forKey:[NSString stringWithFormat:@"%ld",i]];
        
        // footer
        UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [_attriCacheDic setObject:footerAttr forKey:[NSString stringWithFormat:@"%ld_fotter",i]];
    }
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize;
    contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.endPoint.y );
    return contentSize;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = 0.0;
    if ([self.delegate collectionView:self.collectionView layout:self widthAtIndexPath:indexPath]) {
        width = [self.delegate collectionView:self.collectionView layout:self widthAtIndexPath:indexPath];
    }
    CGFloat heigh = self.itemHeigh;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    CGFloat judge = self.endPoint.x + width + self.itemSpacing + self.sectionInset.right;
    //大于就换行
    if (judge > CGRectGetWidth(self.collectionView.frame)) {
        x = self.sectionInset.left;
        y = self.endPoint.y + self.lineSpacing;
        self.isUpdateRow = YES;
        self.endIndex = indexPath.row - 1;
    }else{
        self.isUpdateRow = NO;
        if (indexPath.item == 0) {
            x = self.sectionInset.left;
            y = self.endPoint.y + self.sectionInset.top;
        }else{
            x = self.endPoint.x + self.itemSpacing;
            y = self.endPoint.y - heigh;
        }
    }
    
      //判断是否是最后一行
    if (indexPath.row == (_count-1) && !self.isUpdateRow) {
        self.isUpdateRow = YES;
        self.endIndex = indexPath.row;
    }
    //更新结束位置
    self.endPoint = CGPointMake(x + width, y + heigh);
    
    attr.frame = CGRectMake(x, y, width, heigh);
    
    return attr;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // header
    if ([UICollectionElementKindSectionHeader isEqualToString:elementKind]) {
        UICollectionViewLayoutAttributes *headerAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        CGSize size = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
        }
        CGFloat x = 0.f;
        CGFloat y = self.endPoint.y;
        headerAttri.frame = CGRectMake(x, y, size.width, size.height);
        //更新结束位置
        self.endPoint = CGPointMake(0, y + size.height);
        return headerAttri;
    }
    
    // footer
    else {
        UICollectionViewLayoutAttributes *footerAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
        CGSize size = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
        CGFloat x = 0.f;
        CGFloat y = self.endPoint.y + self.sectionInset.bottom;
        footerAttri.frame = CGRectMake(x, y, size.width, size.height);
        // 更新结束位置
        self.endPoint = CGPointMake(0, y + size.height);
        return footerAttri;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attrsArray = [NSMutableArray new];
    
    NSInteger sectionNum = [self.collectionView numberOfSections];

    for (NSInteger i = 0; i < sectionNum; i ++) {
        UICollectionViewLayoutAttributes *headerAttr = _attriCacheDic[[NSString stringWithFormat:@"%ld_header",i]];
        if (CGRectIntersectsRect(headerAttr.frame, rect)) {
            [attrsArray addObject:headerAttr];
        }
        
        UICollectionViewLayoutAttributes *footerAttr = _attriCacheDic[[NSString stringWithFormat:@"%ld_fotter",i]];
        if (CGRectIntersectsRect(footerAttr.frame, rect)) {
            [attrsArray addObject:footerAttr];
        }
        
        NSArray *itemsAttrs = _attriCacheDic[[NSString stringWithFormat:@"%ld",i]];
        for (UICollectionViewLayoutAttributes *itemAttr in itemsAttrs) {
            if (CGRectIntersectsRect(itemAttr.frame, rect)) {
                [attrsArray addObject:itemAttr];
            }
        }
    }
    
    return  attrsArray;
}

@end
