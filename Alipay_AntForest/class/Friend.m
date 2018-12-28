//
//  Friend.m
//  Alipay_AntForest
//
//  Created by King on 2018/12/26.
//

#import "Friend.h"

@implementation Friend

/**
 如果需要指定“唯一约束”字段, 在模型.m文件中实现该函数,这里指定 name和age 为“唯一约束”.
 */
+(NSArray *)bg_uniqueKeys{
    return @[@"userId"];
}


+(Friend *)creatWithDic:(NSDictionary *)dic {
    
    Friend * friend = [[Friend alloc] init];
    
    friend.userId = [NSString stringWithFormat:@"%@",dic[@"userId"]];
    friend.displayName = [NSString stringWithFormat:@"%@",dic[@"displayName"]];

    friend.canCollectLaterTime = [dic[@"canCollectLaterTime"] longLongValue];
    friend.canCollectEnergy = [dic[@"canCollectEnergy"] boolValue];
    friend.canHelpCollect = [dic[@"canHelpCollect"] boolValue];
    friend.collectableBubbleCount = [dic[@"collectableBubbleCount"] intValue];
    
    return friend;
}

/*
 不可收取能量的用户信息
 {
 realName : 0,
 forestUser : 0,
 treeAmount : 14,
 rank : 1,
 canCollectLaterTime : -1,
 userId : 2088222306961111,
 canCollectEnergy : 0,
 collectableBubbleCount : 0,
 energySummation : 255263,
 headPortrait : ,
 displayName : ,
 canHelpCollect : 0
 }
 */


/*
可收取能量的用户信息：
 {
 realName : 0,
 forestUser : 0,
 treeAmount : 2,
 rank : 4,
 canCollectLaterTime : 1545830609000,
 userId : 2088702292227074,
 canCollectEnergy : 1,
 collectableBubbleCount : 0,
 energySummation : 121917,
 headPortrait : ,
 displayName : ,
 canHelpCollect : 0
 }
 */
@end
