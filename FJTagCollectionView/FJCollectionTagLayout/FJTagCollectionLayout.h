//
//  FJTagCollectionLayout.h
//  CollectionView
//
//  Created by fujin on 16/1/12.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter;

typedef NS_ENUM(NSInteger,FJTagLayoutAligned)
{
  FJTagLayoutAlignedLeft ,
  FJTagLayoutAlignedMiddle,
  FJTagLayoutAlignedRight
};

@class FJTagCollectionLayout;
@protocol FJTagCollectionLayoutDelegate <NSObject>
@required
// item width
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath;

@optional
//section header height
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer height
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
@end

@interface FJTagCollectionLayout : UICollectionViewLayout

@property (nonatomic, weak) id<FJTagCollectionLayoutDelegate> delegate;

@property (nonatomic, assign) UIEdgeInsets sectionInset; //sectionInset ,default UIEdgeInsetsZero

@property (nonatomic, assign) CGFloat lineSpacing;  //line space ,default 10

@property (nonatomic, assign) CGFloat itemSpacing; //item space ,default 10

@property (nonatomic, assign) CGFloat itemHeigh;  //item heigh, default 30

@property (nonatomic, assign) FJTagLayoutAligned layoutAligned;  //layoutAligned, default FJTagLayoutAlignedLeft

@end
