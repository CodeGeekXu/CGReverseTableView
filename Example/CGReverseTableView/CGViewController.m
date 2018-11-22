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

@property (weak, nonatomic) IBOutlet CGReverseTableView *tableView;
@property (nonatomic, assign) NSInteger sections;

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
    self.title = @"Demo";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.sections = 1;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.sections ++;
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 40)];
    header.backgroundColor = [UIColor redColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:header.bounds];
    titleLabel.text = [NSString stringWithFormat:@"tableHeaderView"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [header addSubview:titleLabel];
    self.tableView.tableHeaderView = header;
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 40)];
    footer.backgroundColor = [UIColor redColor];
    UILabel *footerLabel = [[UILabel alloc]initWithFrame:footer.bounds];
    footerLabel.text = [NSString stringWithFormat:@"tableFooterView"];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor whiteColor];
    [footer addSubview:footerLabel];
    self.tableView.tableFooterView = footer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

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
