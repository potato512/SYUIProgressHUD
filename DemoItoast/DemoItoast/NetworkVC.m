//
//  NetworkVC.m
//  DemoItoast
//
//  Created by Herman on 2018/8/15.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "NetworkVC.h"

#import "SYToastView.h"

@interface NetworkVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation NetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"SYNetworkStatusView";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"PositionTop-有图";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"PositionTop-无图";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"PositionTopRountAdjust-有图";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"PositionTopRountAdjust-无图";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"PositionCenterRountAdjust-有图";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"PositionCenterRountAdjust-无图";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"PositionBottomRountAdjust-有图";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"PositionBottomRountAdjust-无图";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIView *view = [[UIApplication sharedApplication].delegate window];
    if (indexPath.row == 0) {
        ToastView.bgroundColor = [UIColor yellowColor];
        ToastView.textFont = [UIFont systemFontOfSize:12.0f];
        ToastView.textColor = [UIColor redColor];
        
        [ToastView showInView:view position:PositionTop message:@"没有网络..没有网络..没有网络..没有网络..没有网络..没有网络" image:[UIImage imageNamed:@"withoutNetwork"] animation:YES];
    } else if (indexPath.row == 1) {
        [ToastView showInView:view position:PositionTop message:@"没有网络..没有网络..没有网络..没有网络..没有网络..没有网络" image:nil animation:YES];
    } else if (indexPath.row == 2) {
        ToastView.bgroundColor = [UIColor greenColor];
        ToastView.textFont = [UIFont systemFontOfSize:13.0f];
        ToastView.textColor = [UIColor blueColor];
        
        [ToastView showInView:view position:PositionCenterRountAdjust message:@"有数据啦" image:[UIImage imageNamed:@"withNetwork"] animation:YES];
    } else if (indexPath.row == 3) {
        [ToastView showInView:view position:PositionCenterRountAdjust message:@"有数据啦" image:nil animation:YES];
    } else if (indexPath.row == 4) {
        [ToastView showInView:view position:PositionTopRountAdjust message:@"连网了...连网了...连网了...连网了...连网了...连网了...连网了...连网了...连网了...连网了..." image:[UIImage imageNamed:@"withNetwork"] animation:YES];
    } else if (indexPath.row == 5) {
        [ToastView showInView:view position:PositionTopRountAdjust message:@"连网了...连网了...连网了...连网了...连网了...连网了...连网了...连网了...连网了...连网了..." image:nil animation:YES];
    } else if (indexPath.row == 6) {
        [ToastView showInView:view position:PositionBottomRountAdjust message:@"下班了" image:[UIImage imageNamed:@"withNetwork"] animation:YES];
    } else if (indexPath.row == 7) {
        [ToastView showInView:view position:PositionBottomRountAdjust message:@"下班了" image:nil animation:YES];
    }
}


@end
