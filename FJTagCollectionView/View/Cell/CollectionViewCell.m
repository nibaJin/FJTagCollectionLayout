//
//  CollectionViewCell.m
//  FJTagCollectionView
//
//  Created by fujin on 16/1/12.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backGroupView.layer.masksToBounds = YES;
    self.backGroupView.layer.cornerRadius = 5.0;
    self.backGroupView.layer.borderWidth = 0.5;
    self.backGroupView.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

@end
