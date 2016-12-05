//
//  YNTrainRealm.h
//  YNTableCellMove
//
//  Created by Lynn on 16/12/1.
//  Copyright © 2016年 Jessica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

@interface YNTrainRealm : RLMObject

@property NSString *trainID;

@property NSString *UID;

/**
 *  通过训练ID添加
 */
+ (void)addRealmWithTrainID:(NSString *)trainID;

+ (void)delRealmWithTrainID:(NSString *)trainID;

+ (BOOL)seleRealmWirhTrainID:(NSString *)trainID ;

+ (void)deletAllTrainRealm;

+ (void)addRealm:(YNTrainRealm *)train;

+ (void)delRealm:(YNTrainRealm *)train;


@end

