//
//  FilterConditionView.m
//  SideBarSiderView
//
//  Created by 左博杨 on 2017/4/22.
//  Copyright © 2017年 左博杨. All rights reserved.
//

#import "FilterConditionView.h"
#import "UIView+Extetion.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

@interface FilterConditionView() <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITextField *textfield;//搜索框
@property (nonatomic,strong) UIView *bottomSetView;//底部设置视图
@end

@implementation FilterConditionView

static NSString *reuseId = @"filterViewCell";

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    self.backgroundColor = [UIColor whiteColor];
    
    //搜索框
    UIView *searchBGView = [[UIView alloc]initWithFrame:CGRectMake(10, 17, 280, 40)];
    searchBGView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    searchBGView.layer.cornerRadius = 4.0;
    [searchBGView addSubview:self.textfield];
    [self addSubview:searchBGView];
    
    //筛选条件列表
    [self addSubview:self.tableView];
    
    //底部设置选项
    [self addSubview:self.bottomSetView];
}

#pragma mark - UITableView 数据源&代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"二级筛选条件";
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"一级筛选条件";
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    [header.textLabel setBackgroundColor:header.backgroundColor];
    [header.textLabel setFont:[UIFont systemFontOfSize:16]];
    [header.textLabel setTextAlignment:NSTextAlignmentLeft];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma mark - private Methods
-(void)cleanAllSettings{
    
}

-(void)doneAllSettings{
    
}

#pragma mark - getters
-(UITextField *)textfield{
    if (!_textfield) {
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(8, 0, 264, 40)];
        _textfield.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
        _textfield.placeholder = @"输入关键字搜索";
        _textfield.font = [UIFont systemFontOfSize:16];
        [_textfield setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        _textfield.returnKeyType = UIReturnKeySearch;//变为搜索按钮
        _textfield.delegate = self;//设置代理
    }
    return _textfield;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 57+12, self.width, self.height-57-12) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 70)];
        _tableView.tableFooterView = footerView;
    }
    return _tableView;
}

-(UIView *)bottomSetView{
    if (!_bottomSetView) {
        _bottomSetView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH-50, self.width, 50)];
        _bottomSetView.backgroundColor = [UIColor whiteColor];
        [[_bottomSetView layer] setShadowOffset:CGSizeMake(0, -1)];
        [[_bottomSetView layer] setShadowRadius:1];
        [[_bottomSetView layer] setShadowOpacity:0.15];
        [[_bottomSetView layer] setShadowColor:[UIColor blackColor].CGColor];
        
        UIButton *cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        [cleanBtn setTitleColor:[UIColor colorWithRed:89/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
        [cleanBtn setTitle:@"清空" forState:UIControlStateNormal];
        cleanBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cleanBtn addTarget:self action:@selector(cleanAllSettings) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cleanBtn.frame), 0, 1, 50)];
        line.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, 149, 50)];
        [doneBtn setTitleColor:[UIColor colorWithRed:89/255.0 green:170/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [doneBtn addTarget:self action:@selector(doneAllSettings) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomSetView addSubview:cleanBtn];
        [_bottomSetView addSubview:doneBtn];
        [_bottomSetView addSubview:line];
    }
    return _bottomSetView;
}
@end
