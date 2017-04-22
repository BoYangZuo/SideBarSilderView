//
//  SideBarView.m
//  SideBarSiderView
//
//  Created by 左博杨 on 2017/4/22.
//  Copyright © 2017年 左博杨. All rights reserved.
//

#import "SideBarView.h"
#import "FilterConditionView.h"
#import "UIView+Extetion.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

@interface SideBarView() <UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *coverView;//遮罩
@property (nonatomic,strong) FilterConditionView *filterView;//筛选视图
@end

@implementation SideBarView

+(void)show{
    SideBarView *obj = [[SideBarView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    [KEYWINDOW addSubview:obj];
}

- (void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.filterView removeObserver:self forKeyPath:@"frame"];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    [self addSubview:self.coverView];
    [self addSubview:self.filterView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0.4;
        self.filterView.x = SCREENW - 300;
    }];
    
    //手势1
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panEvent:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    //手势2
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
    [self.coverView addGestureRecognizer:tap];
    //监听
    [self.filterView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - private Methods
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect new = [change[@"new"] CGRectValue];
        CGFloat x = new.origin.x;
        if (x < SCREENW) {
            self.coverView.alpha = 0.4*(1-x/SCREENW)+0.1;
        }else{
            self.coverView.alpha = 0.0;
        }
    }
}

-(void)panEvent:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translation = [recognizer translationInView:self];
    
    if(UIGestureRecognizerStateBegan == recognizer.state || UIGestureRecognizerStateChanged == recognizer.state){
        
        if (translation.x > 0 ) {//右滑
            self.filterView.x = SCREENW-300 + translation.x;
        }else{//左滑
            
            if (self.filterView.x < SCREENW-300) {
                self.filterView.x = self.filterView.x - translation.x;
            }else{
                self.filterView.x = SCREENW-300;
            }
        }
        
    }else{
        [self tapEvent];
    }
}

-(void)tapEvent{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0.0;
        self.filterView.x = SCREENW;
    } completion:^(BOOL finished) {
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

#pragma mark - getters
-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.0;
    }
    return _coverView;
}

-(FilterConditionView *)filterView{
    if (!_filterView) {
        _filterView = [[FilterConditionView alloc]initWithFrame:CGRectMake(SCREENW, 0, 300, SCREENH)];
    }
    return _filterView;
}

@end
