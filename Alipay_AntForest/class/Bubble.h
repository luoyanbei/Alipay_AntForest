//
//  Bubble.h
//  Alipay_AntForest
//
//  Created by King on 2018/12/26.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h"

@interface Bubble : NSObject

@property(nonatomic,copy)NSString* bID;
@property(nonatomic,copy)NSString* collectStatus;
@property(nonatomic,copy)NSString* userId;
@property(nonatomic,assign)BOOL canHelpCollect;
@property(nonatomic,assign)long long produceTime;

+(Bubble *)creatWithDic:(NSDictionary *)dic;

@end
