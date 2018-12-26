//
//  Bubble.m
//  Alipay_AntForest
//
//  Created by King on 2018/12/26.
//

#import "Bubble.h"

@implementation Bubble

/**
 如果需要指定“唯一约束”字段, 在模型.m文件中实现该函数
 */
+(NSArray *)bg_uniqueKeys{
    return @[@"bID"];
}

+(Bubble *)creatWithDic:(NSDictionary *)dic {
    
    Bubble * bubble = [[Bubble alloc] init];
    
    bubble.bID = [NSString stringWithFormat:@"%@",dic[@"id"]];
    bubble.userId = [NSString stringWithFormat:@"%@",dic[@"userId"]];
    bubble.collectStatus = [NSString stringWithFormat:@"%@",dic[@"collectStatus"]];
    bubble.produceTime = [dic[@"produceTime"] longLongValue];
    bubble.canHelpCollect = [dic[@"canHelpCollect"] boolValue];
    
    return bubble;
    
}


/*
 bubbles : [
 {
 collectStatus : INSUFFICIENT,        //收取状态，INSUFFICIENT 不足的，AVAILABLE 可收取，
 userId : 2088xxxxxxxxxx384,            //用户的id
 canHelpCollect : 1,                    //是否可被帮助收取
 id : 76012195,                        //气泡的id
 produceTime : 1536934343000,
 fullEnergy : 52,
 overTime : 1537193543000,
 business : {
 nightIconUrl : https://zos.alipayobjects.com/rmsportal/GydawUvGZiOzxMM.png,
 id : 2,
 bizType : ditie,
 smallIconDisplayName : 地铁出行,
 bigIconDisplayName : 地铁出行,
 dayIconUrl : https://zos.alipayobjects.com/rmsportal/ulnllVtPwKlmuEb.png
 }]
 */

@end
