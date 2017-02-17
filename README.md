# FJTagCollectionLayout
标签规则布局（居左 居中 居右）  
### 实现代码
``` bash
// 例子 - 可根据自己的需求来变 
    FJTagCollectionLayout *tagLayout = [[FJTagCollectionLayout alloc] init];
    
    //section inset
    tagLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    // 行间距
    tagLayout.lineSpacing = 10;
    
    // item间距
    tagLayout.itemSpacing = 10;
    
    // item高度
    tagLayout.itemHeigh = 30;
    
    // 对齐形式
    tagLayout.layoutAligned = FJTagLayoutAlignedRight;
    
    tagLayout.delegate = self;
```
### 居左
![left](https://github.com/nibaJin/FJTagCollectionLayout/tree/master/Screenshots/left.png)
### 局右
![right](https://github.com/nibaJin/FJTagCollectionLayout/tree/master/Screenshots/right.png)
### 局中
![middle](https://github.com/nibaJin/FJTagCollectionLayout/tree/master/Screenshots/middle.png)

