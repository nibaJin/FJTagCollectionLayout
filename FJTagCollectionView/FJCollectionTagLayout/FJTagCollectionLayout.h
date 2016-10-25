//
//  FJTagCollectionLayout.h
//  CollectionView
//
//  Created by fujin on 16/1/12.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FJTagLayoutAligned)
{
  FJTagLayoutAlignedLeft ,
  FJTagLayoutAlignedMiddle,
  FJTagLayoutAlignedRight
};

@class FJTagCollectionLayout;
@protocol FJTagCollectionLayoutDelegate <NSObject>
@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface FJTagCollectionLayout : UICollectionViewLayout

@property (nonatomic, weak) id<FJTagCollectionLayoutDelegate> delegate;

@property (nonatomic, assign) UIEdgeInsets sectionInset; //sectionInset

@property (nonatomic, assign) CGFloat lineSpacing;  //line space

@property (nonatomic, assign) CGFloat itemSpacing; //item space

@property (nonatomic, assign) CGFloat itemHeigh;  //item heigh

@property (nonatomic, assign) FJTagLayoutAligned layoutAligned;  //layoutAligned

@end
