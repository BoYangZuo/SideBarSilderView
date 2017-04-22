//
//  ViewController.m
//  SideBarSiderView
//
//  Created by 左博杨 on 2017/4/22.
//  Copyright © 2017年 左博杨. All rights reserved.
//

#import "ViewController.h"
#import "SideBarView.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton *sideViewShowBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sideViewShowBtn];
}

#pragma mark - private Methods
-(void)showSideBar{
    [SideBarView show];
}

#pragma mark - getters
-(UIButton *)sideViewShowBtn{
    if (!_sideViewShowBtn) {
        _sideViewShowBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 100, 50)];
        _sideViewShowBtn.backgroundColor = [UIColor yellowColor];
        [_sideViewShowBtn addTarget:self action:@selector(showSideBar) forControlEvents:UIControlEventTouchUpInside];
        [_sideViewShowBtn setTitle:@"弹出侧栏筛选视图" forState:UIControlStateNormal];
        [_sideViewShowBtn setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    }
    return _sideViewShowBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
