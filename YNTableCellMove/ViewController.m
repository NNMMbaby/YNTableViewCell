//
//  ViewController.m
//  YNTableCellMove
//
//  Created by Lynn on 16/12/2.
//  Copyright © 2016年 Jessica. All rights reserved.
//

#import "ViewController.h"
#import "YNMoveTableView.h"
#import "YNTrainRealm.h"

@interface ViewController ()<YNMoveTableViewDataSource, YNMoveTableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)addTrainRealms{
    
    
    [YNTrainRealm addRealmWithTrainID:@"33"];
    [YNTrainRealm addRealmWithTrainID:@"15"];
    [YNTrainRealm addRealmWithTrainID:@"23"];
    [YNTrainRealm addRealmWithTrainID:@"06"];
    [YNTrainRealm addRealmWithTrainID:@"19"];
    [YNTrainRealm addRealmWithTrainID:@"01"];
    [YNTrainRealm addRealmWithTrainID:@"18"];
    [YNTrainRealm addRealmWithTrainID:@"21"];
    [YNTrainRealm addRealmWithTrainID:@"09"];
    [YNTrainRealm addRealmWithTrainID:@"13"];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray new];
    
    
    // 添加训练
    [self addTrainRealms];
    
    RLMResults *trains = [YNTrainRealm allObjects];
    
//    NSLog(@"%@", trains);
    
    for (int i = 0; i < trains.count; i ++) {
        
        YNTrainRealm *realm = trains[i];
        
        [_dataSource addObject: realm.trainID];
        
    }
//    NSLog(@"%@", _dataSource);

    
    YNMoveTableView *tableView = [[YNMoveTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    YNTrainRealm *realm = _dataSource[indexPath.row];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"训练 %@", _dataSource[indexPath.row]];
    
    return cell;
}

- (NSArray *)dataSourceArrayInTableView:(YNMoveTableView *)tableView
{

    return _dataSource.copy;
    
}

- (void)tableView:(YNMoveTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray
{

    NSLog(@"%@",newDataSourceArray);
    
    [YNTrainRealm deletAllTrainRealm];
    

    for (int i = 0; i < newDataSourceArray.count; i ++) {
        
        
        [YNTrainRealm addRealmWithTrainID:newDataSourceArray[i]];
        
    }
    _dataSource = newDataSourceArray.mutableCopy;
    
    
}


// 指定哪些行可以被编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
// 第三步.指定编辑的风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;// 前五个分区是删除
    
}
// 第四步.编辑完成 先操作数据源 再删除UI 否则崩 删完ui就会和数据对应不上
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 删除 delete
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除数据库
        NSString *trainId = _dataSource[indexPath.row];
        
        [YNTrainRealm delRealmWithTrainID: trainId];
        
        // 入而当前分组只有一个人 删除之后 其分组也应该被删除掉
        [_dataSource removeObjectAtIndex:indexPath.row]; // 删除当前行数据
        
    
        // 更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)]; // indexPath用数组传进去
        
        
    }
    
}



@end
