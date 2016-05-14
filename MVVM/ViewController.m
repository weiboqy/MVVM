//
//  ViewController.m
//  MVVM
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "ViewController.h"
#import "CellItemModel.h"
#import "CellItemSectionModel.h"
#import "CellItemTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataSourceArr;

@end

static NSString *const tableViewCellID = @"tableViewCellID";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubview];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupSubview {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    view.backgroundColor = [UIColor blueColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = view;
    [self.view addSubview:self.tableView];
    
    // 创建模型
    CellItemModel *itemModel = [[CellItemModel alloc]init];
    itemModel.itemName = @"我的任务";
    itemModel.itemImage = [UIImage imageNamed:@"icon-list01"];
    itemModel.ClickItemOperation = ^{
        NSLog(@"点击了我的任务");
    };
    itemModel.type = CellItemTypeSysytem;
    itemModel.detailName = @"赚金币";
    
#pragma mark  =====
    
    
    CellItemModel *itemModel1 = [[CellItemModel alloc]init];
    itemModel1.itemName = @"我的任务1";
    itemModel1.itemImage = [UIImage imageNamed:@"icon-list01"];
    itemModel1.detailImage = [UIImage imageNamed:@"icon-new"];
    itemModel1.ClickItemOperation = ^{
        NSLog(@"点击了我的任务1");
    };
    itemModel1.type = CellItemTypeSysytem;
    
    CellItemModel *itemModel2 = [[CellItemModel alloc]init];
    itemModel2.itemName = @"我的任务2";
    itemModel2.itemImage = [UIImage imageNamed:@"icon-list01"];
    itemModel2.ClickItemOperation = ^{
        NSLog(@"点击了我的任务2");
    };
    itemModel2.type = CellItemTypeSwitch;
    itemModel2.SwitchValueChanged = ^(BOOL isOn){
        NSLog(@"%d", isOn);
    };
    
    CellItemSectionModel *sm = [[CellItemSectionModel alloc]init];
    sm.itemArray = @[itemModel, itemModel1, itemModel2];
    sm.sectionHeaderHeight = 100;
    
#pragma mark  =======
    
    CellItemModel *itemModel3 = [[CellItemModel alloc]init];
    itemModel3.itemName = @"我的任务3";
    itemModel3.itemImage = [UIImage imageNamed:@"icon-list01"];
    itemModel3.ClickItemOperation = ^{
        NSLog(@"点击了我的任务3");
    };
    itemModel3.type = CellItemTypeSysytem;
    itemModel3.detailName = @"赚金币";
    
    CellItemSectionModel *sm1 = [[CellItemSectionModel alloc]init];
    sm1.itemArray = @[itemModel3];
    sm1.sectionHeaderHeight = 100;
    
    // 创建数据源
    self.dataSourceArr = @[sm, sm1];
}

#pragma mark ------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CellItemSectionModel *sm = self.dataSourceArr[section];
    return sm.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    if (!cell) {
        cell = [[CellItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellID];
    }
    // 取模型
    CellItemSectionModel *sm = self.dataSourceArr[indexPath.section];
    CellItemModel *model = sm.itemArray[indexPath.row];
    cell.item = model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     CellItemSectionModel *sm = self.dataSourceArr[section];
    return sm.sectionHeaderHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellItemSectionModel *sm = self.dataSourceArr[indexPath.section];
    CellItemModel *model = sm.itemArray[indexPath.row];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
