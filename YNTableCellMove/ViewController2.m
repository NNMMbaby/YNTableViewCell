//
//  ViewController2.m
//  YNTableCellMove
//
//  Created by 李艳楠 on 16/12/5.
//  Copyright © 2016年 Jessica. All rights reserved.
//

#import "ViewController2.h"
#import "YNMoveTableView.h"


@interface ViewController2 ()<YNMoveTableViewDataSource, YNMoveTableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray new];
    for (NSInteger section = 0; section < 3; section ++) {
        NSMutableArray *sectionArray = [NSMutableArray new];
        for (NSInteger row = 0; row < 5; row ++) {
            [sectionArray addObject:[NSString stringWithFormat:@"    第%ld组  %ld行", section, row]];
        }
        [_dataSource addObject:sectionArray];
    }
    
    YNMoveTableView *tableView = [[YNMoveTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    tableView.gestureMinimumPressDuration = 1.0;
    tableView.drawMovalbeCellBlock = ^(UIView *movableCell){
        movableCell.layer.shadowColor = [UIColor grayColor].CGColor;
        movableCell.layer.masksToBounds = NO;
        movableCell.layer.cornerRadius = 0;
        movableCell.layer.shadowOffset = CGSizeMake(-5, 0);
        movableCell.layer.shadowOpacity = 0.4;
        movableCell.layer.shadowRadius = 5;
    };
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (NSArray *)dataSourceArrayInTableView:(YNMoveTableView *)tableView
{
    return _dataSource.copy;
}

- (void)tableView:(YNMoveTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray
{
    _dataSource = newDataSourceArray.mutableCopy;
}

// 指定哪些行可以被编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
// 第四步.编辑完成 先操作数据源 再删除UI 否则崩 删完ui就会和数据对应不上
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSMutableArray *sectionArray = _dataSource[indexPath.section];
        [sectionArray removeObjectAtIndex:indexPath.row];

        // 更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)]; // indexPath用数组传进去
        
    }
    
}

@end
