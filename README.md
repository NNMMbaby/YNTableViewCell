# YNTableViewCell



####cell的移动和删除 
####数据库的持久化保存 （realm）

####    -





 ![image](https://github.com/NNMMbaby/YNTableViewCell/blob/master/cell%20移动与删除.gif)
 
 
 #Realm的增加 删除 查找
 
 


```

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



```