//
//  UIScrollView+TouchEvent.m
//  FJTagCollectionView
//
//  Created by fujin on 16/1/14.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "UIScrollView+TouchEvent.h"

@implementation UIScrollView (TouchEvent)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}
@end
