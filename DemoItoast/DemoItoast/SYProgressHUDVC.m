//
//  SYProgressHUDVC.m
//  DemoItoast
//
//  Created by Herman on 2020/4/19.
//  Copyright © 2020 zhangshaoyu. All rights reserved.
//

#import "SYProgressHUDVC.h"
#import "SYUIProgressHUD.h"

@interface SYProgressHUDVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation SYProgressHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"SYProgressHUD";
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hideKeyboard" style:UIBarButtonItemStyleDone target:self action:@selector(hideKeyboardClick)];
    //
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    //
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headerView.backgroundColor = UIColor.whiteColor;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, (headerView.frame.size.width - 40), (headerView.frame.size.height - 20))];
    textField.textColor = UIColor.blackColor;
    textField.layer.borderColor = [UIColor.blackColor colorWithAlphaComponent:0.3].CGColor;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 10;
    textField.layer.masksToBounds = YES;
    [headerView addSubview:textField];
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = [UIView new];
    
    // 初始化
//    UIView *view = UIApplication.sharedApplication.delegate.window;
    UIView *view = self.view;
    [SYUIProgressHUD setContainerView:view];
    [SYUIProgressHUD setActivityColor:UIColor.redColor];
    [SYUIProgressHUD setHUDBackgroundColor:UIColor.greenColor];
    [SYUIProgressHUD setHUDCorner:15];
    [SYUIProgressHUD setHUDSize:CGSizeMake(300, 50)];
//    [SYUIProgressHUD setHUDPosition:80];
    
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)dealloc
{
    [SYUIProgressHUD hide];
}

- (void)hideKeyboardClick
{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSString *text = self.array[indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *text = self.array[indexPath.row];
    if ([text isEqualToString:@"隐藏HUD"]) {
        [SYUIProgressHUD hide];
    } else if ([text isEqualToString:@"显示HUD不隐藏 仅信息"]) {
        [SYUIProgressHUD showMessage:self.textArray[arc4random() % self.textArray.count]];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 仅信息"]) {
        [SYUIProgressHUD showMessageAutoHide:self.textArray[arc4random() % self.textArray.count]];
    } else if ([text isEqualToString:@"显示HUD不隐藏 仅符号指示器"]) {
        [SYUIProgressHUD showActivity];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 仅符号指示器"]) {
        [SYUIProgressHUD showActivityAutoHide];
    } else if ([text isEqualToString:@"显示HUD不隐藏隐藏 仅图标"]) {
        [SYUIProgressHUD showIcon:@[[UIImage imageNamed:@"withNetwork"]]];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 仅图标"]) {
        [SYUIProgressHUD showIconAutoHide:@[[UIImage imageNamed:@"withoutNetwork"]]];
    } else if ([text isEqualToString:@"显示HUD不隐藏 信息和符号指示器"]) {
        [SYUIProgressHUD showMessageWithActivity:self.textArray[arc4random() % self.textArray.count]];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 信息和符号指示器"]) {
        [SYUIProgressHUD showMessageWithActivityAutoHide:self.textArray[arc4random() % self.textArray.count]];
    } else if ([text isEqualToString:@"显示HUD不隐藏 信息和图标"]) {
        [SYUIProgressHUD showMessageWithIcon:self.textArray[arc4random() % self.textArray.count] icon:@[[UIImage imageNamed:@"error"]]];
    } else if ([text isEqualToString:@"显示HUD自动隐藏 信息和图标"]) {
        [SYUIProgressHUD showMessageWithIcon:self.textArray[arc4random() % self.textArray.count] icon:@[[UIImage imageNamed:@"success"]]];
    }
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"隐藏HUD", @"显示HUD不隐藏 仅信息", @"显示HUD自动隐藏 仅信息", @"显示HUD不隐藏 仅符号指示器", @"显示HUD自动隐藏 仅符号指示器", @"显示HUD不隐藏隐藏 仅图标", @"显示HUD自动隐藏 仅图标", @"显示HUD不隐藏 信息和符号指示器", @"显示HUD自动隐藏 信息和符号指示器", @"显示HUD不隐藏 信息和图标", @"显示HUD自动隐藏 信息和图标"];
    }
    return _array;
}

- (NSArray *)textArray
{
    if (_textArray == nil) {
        _textArray = @[@"出错了，赶紧找问题吧！", @"正确！", @"因为你的不努力，现在发现了很多存在的隐患，你必须在规定的时间点完成所有的工作。否则后果很严重！"];
    }
    return _textArray;
}

@end
