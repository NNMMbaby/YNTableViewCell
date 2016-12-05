//
//  YNTrainRealm.m
//  YNTableCellMove
//
//  Created by Lynn on 16/12/1.
//  Copyright © 2016年 Jessica. All rights reserved.
//

#import "YNTrainRealm.h"

static NSString *currentUID = @"111";

@implementation YNTrainRealm


+ (void)addRealmWithTrainID:(NSString *)trainID {
    
    YNTrainRealm *train = [[YNTrainRealm alloc] init];
    train.UID = [NSString stringWithFormat:@"%@", currentUID];
    
    train.trainID = [NSString stringWithFormat:@"%@",trainID];
    
    if ([self seleRealmWirhTrainID:trainID]){
        
    } else {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject: train];
        [realm commitWriteTransaction];
        
    }
    
    
    
}

+ (void)delRealmWithTrainID:(NSString *)trainID {
    
    
    // 查询当前realm
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"UID = %@ AND trainID = %@", currentUID, trainID];
    RLMResults *trains = [YNTrainRealm objectsWithPredicate:pred];
    
    // 从 Realm 中删除所有数据
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:trains];
    [realm commitWriteTransaction];
    
    
}


+ (BOOL)seleRealmWirhTrainID:(NSString *)trainID {
    
    // 条件查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"UID = %@ AND trainID = %@", currentUID, trainID];
    RLMResults *trains = [YNTrainRealm objectsWithPredicate:pred];
    
    
    // 不存在就添加
    if (trains.count == 0) {
        
        return NO;
        
    } else {
        
        return YES;
        
    }
    
    return NO;
    
    
}

+ (void)deletAllTrainRealm {
    
    RLMRealm *realm = [RLMRealm defaultRealm];

    // 从 Realm 中删除所有数据
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

+ (void)addRealm:(YNTrainRealm *)train {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject: train];
    [realm commitWriteTransaction];
    
    
}

+ (void)delRealm:(YNTrainRealm *)train {
    RLMRealm *defaulttrealm = [RLMRealm defaultRealm];
    
    // 从 Realm 中删除所有数据
    [defaulttrealm beginWriteTransaction];
    [defaulttrealm deleteObject:train];
    [defaulttrealm commitWriteTransaction];
}





@end
