//
//  YGUpgrateSwitch.m
//  标题浮动
//
//  Created by BEN on 16/4/12.
//  Copyright © 2016年 BEN. All rights reserved.
/*
 
 initWithFrame 和 init
 关键在理解 UIScrollView的bounds属性，bounds是针对自身坐标系统的，UIScrollView可以通过setContentSize设置范围大小，往往都会超出屏幕的大小，因为UIScrollView就是满足手机屏幕 比较小而起到拓展范围的作用， 这个时候滑动UIScrollView，UIScrollView 的bounds就会发生变化。
 
*/

#import "YGUpgrateSwitch.h"
#import "YGLabel.h"

@implementation YGUpgrateSwitch 
{
     UIScrollView   *_smallScrollView;
     UIScrollView   *_bigScrollView;
     NSMutableArray *_labelArry;
     UIView         *_redSignBar;
    CGRect          signRect;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _smallScrollView = [[UIScrollView alloc] init];
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        _smallScrollView.showsVerticalScrollIndicator = NO;
        _bigScrollView = [[UIScrollView alloc] init];
        _bigScrollView.pagingEnabled = YES;
        _bigScrollView.showsHorizontalScrollIndicator = NO;
        _bigScrollView.showsVerticalScrollIndicator = NO;
        _bigScrollView.backgroundColor = [UIColor orangeColor];
        _labelArry = [NSMutableArray array];
        _redSignBar = [[UIView alloc] init];
        _redSignBar.backgroundColor = BACK_COLOR;
    }
    return  self;
}
- (void)layoutSubviews
{
    [_smallScrollView setFrame:CGRectMake(0, 0, SELF_WIDTH, SMALL_SCROLLVIEW_HEIGHT)];
    [_bigScrollView   setFrame:CGRectMake(0, SMALL_SCROLLVIEW_HEIGHT, SELF_WIDTH, SELF_HEIGHT - SMALL_SCROLLVIEW_HEIGHT)];
    [self addLabelTitle];
    [self addSubview:_smallScrollView];
    [self addSubview:_bigScrollView];
    [_smallScrollView addSubview:_redSignBar];
    _bigScrollView.delegate = self;
    [_bigScrollView setContentSize:CGSizeMake(SELF_WIDTH * self.titleArray.count, 0)];
    
}
- (void)addLabelTitle
{
    NSInteger count = self.titleArray.count;

    CGFloat  space = (_smallScrollView.bounds.size.width - EVERY_TITLE_WIDTH * count)/(count + 1);
    for (int i = 0; i < self.titleArray.count; i++) {
        YGLabel *label = [[YGLabel alloc] initWithFrame:CGRectZero];
        label.text = self.titleArray[i];
        label.showColor = NO;
        label.tag = i;
        CGFloat originX = space + (space + EVERY_TITLE_WIDTH) * i;
        label.frame = CGRectMake(originX, 0, EVERY_TITLE_WIDTH, SMALL_SCROLLVIEW_HEIGHT);
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)]];
        [_smallScrollView  addSubview:label];
        [_labelArry addObject:label];
    }
    YGLabel *firstLab = [_labelArry firstObject];
    firstLab.showColor = YES;
    _redSignBar.frame = CGRectMake(firstLab.frame.origin.x, SMALL_SCROLLVIEW_HEIGHT - 8, EVERY_TITLE_WIDTH, 3);
}
- (void)titleClick:(UITapGestureRecognizer *)gesture
{
    YGLabel *label = (YGLabel *)gesture.view;
    
    CGFloat x = SELF_WIDTH * label.tag;
    
   [_bigScrollView setContentOffset:CGPointMake(x, 0)  animated:YES]; //这个动画多长时间？
//    [UIScrollView animateWithDuration:5 animations:^ { [_bigScrollView setContentOffset:CGPointMake(x, 0)]; }];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat offX = scrollView.contentOffset.x / SELF_WIDTH;
    NSInteger valueOffX = (NSInteger)offX;
    for (YGLabel *label in _labelArry) {
        label.showColor = NO;
    }
    YGLabel *slectedLab =  _labelArry[valueOffX];
    slectedLab.showColor = YES;
    signRect = slectedLab.frame;
    [self animationToRedSign];
    
    UIViewController *childVC = self.childVCArray[valueOffX];
    childVC.view.frame = _bigScrollView.bounds;
    NSLog(@"%f",_bigScrollView.bounds.origin.y);
    if (childVC.view.superview) {
        return;
    }
    [_bigScrollView addSubview:childVC.view];
}

- (void)animationToRedSign
{
    [UIView animateWithDuration:0.1 animations:^{
        _redSignBar.frame = CGRectMake(signRect.origin.x, SMALL_SCROLLVIEW_HEIGHT - 8, EVERY_TITLE_WIDTH, 3);
    }];
}
// 会先调用 initWithFrame方法
- (id)init
{
    if (self = [super init]) {
        

    }
    return  self;
}
@end
