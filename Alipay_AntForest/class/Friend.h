//
//  Friend.h
//  Alipay_AntForest
//
//  Created by King on 2018/12/26.
//
#import <Foundation/Foundation.h>
#import "BGFMDB.h"

@interface Friend : NSObject

@property(nonatomic,copy)NSString* userId;
@property(nonatomic,copy)NSString* displayName;
@property(nonatomic,assign)long long canCollectLaterTime;

@property(nonatomic,assign)BOOL canCollectEnergy;
@property(nonatomic,assign)BOOL canHelpCollect;
@property(nonatomic,assign) int collectableBubbleCount;

+(Friend *)creatWithDic:(NSDictionary *)dic;

@end
