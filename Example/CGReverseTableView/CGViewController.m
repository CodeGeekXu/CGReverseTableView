//
//  CGViewController.m
//  CGReverseTableView
//
//  Created by codegeekxu@gmail.com on 11/22/2018.
//  Copyright (c) 2018 codegeekxu@gmail.com. All rights reserved.
//

#import "CGViewController.h"
#import "CGReverseTableView.h"
#import <MJRefresh/MJRefresh.h>

@interface CGViewController ()<CGReverseTableViewDataSource, CGReverseTableViewDelegate>

@property (nonatomic, strong) CGReverseTableView *tableView;

@end

@implementation CGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubViews
{
    CGReverseTableView *tableView = [[CGReverseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    [tableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 40;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 40)];
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:footer.bounds];
//    titleLabel.text = [NSString stringWithFormat:@"  footer%ld",section];
//    [footer addSubview:titleLabel];
//
//    return footer;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 40)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:header.bounds];
    titleLabel.text = [NSString stringWithFormat:@"  header%ld",section];
    [header addSubview:titleLabel];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"section:%ld   row:%ld",indexPath.section,indexPath.row];
    
    return cell;
}

@end
