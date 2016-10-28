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

@interface ViewController () <FJTagCollectionLayoutDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *fakeDataArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = @[@"头条",@"热点新闻",@"体育杂志",@"本地",@"财经",@"暴雪游戏帖",@"图片",@"轻松一刻",@"LOL",@"段子手",@"军事",@"房产",@"English",@"家居",@"原创大型喜剧",@"游戏英雄联盟",@"游戏英雄联盟",@"头条",@"热点新闻",@"体育杂志",@"本地",@"财经",@"暴雪游戏帖",@"图片",@"轻松一刻",@"LOL",@"段子手",@"军事",@"房产",@"English",@"家居",@"原创大型喜剧",@"游戏英雄联盟"];
    
    self.fakeDataArray = [NSMutableArray arrayWithArray:array];
    
    //配置collectionView
    [self configCollectionView];
}

- (void)configCollectionView
{
    FJTagCollectionLayout *tagLayout = [[FJTagCollectionLayout alloc] init];
    tagLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    tagLayout.lineSpacing = 10;
    tagLayout.itemSpacing = 10;
    tagLayout.itemHeigh = 30;
    tagLayout.layoutAligned = FJTagLayoutAlignedRight; // 对齐形式
    tagLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64) collectionViewLayout:tagLayout];
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
}

#pragma mark  ------- UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fakeDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
        cell.contentLabel.text = self.fakeDataArray[indexPath.item];
        cell.indexPath = indexPath;
         return cell;
}

#pragma mark  ------- FJTagCollectionLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJTagCollectionLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath
{
        CGSize size = CGSizeZero;
        size.height = 30;
        //计算字的width 这里主要font 是字体的大小
        CGSize temSize = [self sizeWithString:self.fakeDataArray[indexPath.item] fontSize:14];
        size.width = temSize.width + 20 + 1; //20为左右空10
        
        return size.width;
}

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
