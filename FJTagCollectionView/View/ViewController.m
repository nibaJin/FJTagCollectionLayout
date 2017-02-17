//
//  ViewController.m
//  FJTagCollectionView
//
//  Created by fujin on 16/1/12.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "ViewController.h"
#import "FJTagCollectionLayout.h"
#import "CollectionViewCell.h"
#import "CollectionHeadOrFooterView.h"

@interface ViewController () <FJTagCollectionLayoutDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSDictionary *fakeDic;
@property (strong, nonatomic) NSArray *sortKeys;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 假数据
    NSArray *array1 = @[@"头条",@"热点新闻",@"体育杂志",@"本地",@"财经",@"暴雪游戏帖",@"图片",@"轻松一刻",@"LOL",@"段子手",@"军事",@"房产",@"English",@"家居",@"原创大型喜剧",@"游戏英雄联盟"];
    NSArray *array2 = @[@"穿越火线",@"飞车",@"剁手联盟",@"问道",@"无极",@"头条",@"穿越火线",@"飞车",@"剁手联盟",@"问道",@"无极",@"头条",@"热点新闻",@"体育杂志",@"本地",@"财经",@"暴雪游戏帖",@"图片",@"轻松一刻",@"LOL",@"段子手",@"军事",@"房产",@"English",@"家居",@"原创大型喜剧",@"游戏英雄联盟"];
    NSArray *array3 = @[@"招行",@"农行基金",@"挖财",@"支付宝理财",@"银行理财",@"现金巴士",@"招行",@"农行基金",@"挖财",@"支付宝理财",@"银行理财",@"现金巴士",@"体育杂志",@"本地",@"财经",@"暴雪游戏帖",@"图片",@"轻松一刻",@"LOL",@"段子手",@"军事",@"房产",@"English"];
    
    self.sortKeys = @[@"新闻类",@"游戏类",@"理财类"];
    self.fakeDic = @{@"新闻类":array1,@"游戏类":array2,@"理财类":array3};
    
    //配置collectionView
    [self configCollectionView];
}

- (void)configCollectionView
{
    // 例子 - 可根据自己的需求来变 
    FJTagCollectionLayout *tagLayout = [[FJTagCollectionLayout alloc] init];
    
    //section inset
    tagLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 行间距
    tagLayout.lineSpacing = 10;
    
    // item间距
    tagLayout.itemSpacing = 10;
    
    // item高度
    tagLayout.itemHeigh = 30;
    
    // 对齐形式
    tagLayout.layoutAligned = FJTagLayoutAlignedMiddle;
    
    tagLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64) collectionViewLayout:tagLayout];
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeadOrFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeadOrFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
}

#pragma mark  ------- UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sortKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.fakeDic[self.sortKeys[section]];
    return sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    NSArray *sectionArray = self.fakeDic[self.sortKeys[indexPath.section]];
    cell.contentLabel.text = sectionArray[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionHeadOrFooterView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.titleLabel.text = [NSString stringWithFormat:@"%@",self.sortKeys[indexPath.section]];
        return headerView;
    } else {
        CollectionHeadOrFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.titleLabel.text = [NSString stringWithFormat:@"%@_footer",self.sortKeys[indexPath.section]];
        return footerView;
    }
}

#pragma mark  ------- FJTagCollectionLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath
{
        CGSize size = CGSizeZero;
        size.height = 30;
        //计算字的width 这里主要font 是字体的大小
        NSArray *sectionArray = self.fakeDic[self.sortKeys[indexPath.section]];
        CGSize temSize = [self sizeWithString:sectionArray[indexPath.item] fontSize:14];
        size.width = temSize.width + 20 + 1; //20为左右空10
        
        return size.width;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 40.f);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
//{
//    return CGSizeMake(CGRectGetWidth(self.view.frame), 40.f);
//}

#pragma mark - uuuuu
- (CGSize)sizeWithString:(NSString *)str fontSize:(float)fontSize
{
    CGSize constraint = CGSizeMake(self.view.frame.size.width - 40, fontSize + 1);
    
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize retSize = [str boundingRectWithSize:constraint
                                       options:
                      NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attribute
                                       context:nil].size;
    tempSize = retSize;
    
    return tempSize ;
}

- (void)dealloc
{
    NSLog(@"delloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
