
#import "H5WebViewController.h"
#import "Header.h"

@class NBLoadRequestEvent;


@interface H5WebViewController ()

@end

@implementation H5WebViewController


+(NSString*)getNumberRandom:(int)count
{
    NSString *strRandom = @"";
    
    for(int i=0; i<count; i++)
    {
        strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    return strRandom;
}

//获取能量排行榜
+(void)getListRankingWithStartPoint:(int)startpoint
{
    
    APListData *jdata=[APListData sharedInstance];
    
    long timems=[[NSDate  date] timeIntervalSince1970]*1000;
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", timems];
    
    NSString *randNum=[H5WebViewController getNumberRandom:16];
    
    NSString * pointStr = startpoint<=1?@"":[NSString stringWithFormat:@"%d",startpoint];
    
    NSString * arg0 = [NSString stringWithFormat:@"[{\"handlerName\":\"rpc\",\"data\":{\"operationType\":\"alipay.antmember.forest.h5.queryEnergyRanking\",\"requestData\":[{\"startPoint\":\"%@\",\"pageSize\":20,\"av\":\"5\",\"ct\":\"ios\"}],\"disableLimitView\":true},\"callbackId\":\"rpc_15368300951600.%@\"}]",pointStr,randNum];
    
    NSString *arg2=[NSString stringWithFormat:@"https://60000002.h5app.alipay.com/app/src/listRank.html"];
    
    PSDJsBridge *jsB=jdata.jsBridge;
    
    NSLog(@"jsb=(%@)",jsB);
    
    [jsB _doFlushMessageQueue:arg0 url:arg2];
    
    
}

//帮助他人收取能量
+(void)helpCollectBubbles:(id)mbrige bubbleId:(NSString*)bID userId :(NSString*)userID
{
    NSLog(@"help--(%@)--collect--(%@)",userID,bID);
    
    long timems=[[NSDate  date] timeIntervalSince1970]*1000;
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", timems];
    NSString *randNum=[H5WebViewController getNumberRandom:16];
    
    
    NSString *arg1 = [NSString stringWithFormat:@"[{\"handlerName\":\"rpc\",\"data\":{\"operationType\":\"alipay.antmember.forest.h5.forFriendCollectEnergy\",\"requestData\":[{\"targetUserId\":%@,\"bubbleIds\":[%@],\"av\":\"5\",\"ct\":\"ios\"}],\"disableLimitView\":true},\"callbackId\":\"rpc_15371070827940.%@\"},{\"handlerName\":\"remoteLog\",\"data\":{\"seedId\":\"ANTFOREST-BEHAVIOR-CLICK-COLLECT\",\"param1\":\"shareBiz=none^bubbleId=%@^actionUserId=%@^type=behavior^currentTimestamp=%@\",\"param2\":\"monitor_type=clicked^remoteType=info^pageName=home.html^pageState=friend%@_enterhomeOff\",\"bizType\":\"antForest\"},\"callbackId\":\"remoteLog_15371070827960.%@\"}]",userID,bID,randNum,bID,userID,timeStamp,userID,randNum];
    
    
    NSString *arg2=[NSString stringWithFormat:@"https://60000002.h5app.alipay.com/app/src/home.html?userId=%@",userID];
    PSDJsBridge *jsB=mbrige;
    [jsB _doFlushMessageQueue:arg1 url:arg2];
    
}



+(void)collectBubbles:(id)mbrige bubbleId:(NSString*)bID userId :(NSString*)userID
{
    
    long timems=[[NSDate  date] timeIntervalSince1970]*1000;
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", timems];
    NSString *randNum=[H5WebViewController getNumberRandom:16];
    NSString *arg1=[NSString stringWithFormat:@"[{\"handlerName\":\"remoteLog\",\"data\":{\"seedId\":\"ANTFOREST-BEHAVIOR-CLICK-COLLECT\",\"param1\":\"shareBiz=none^bubbleId=%@^actionUserId=%@^type=behavior^currentTimestamp=%@\",\"param2\":\"monitor_type=clicked^remoteType=info^pageName=home.html^pageState=friend%@_enterhomeOff\",\"bizType\":\"antForest\"},\"callbackId\":\"remoteLog_15105601282940.%@\"},{\"handlerName\":\"rpc\",\"data\":{\"operationType\":\"alipay.antmember.forest.h5.collectEnergy\",\"requestData\":[{\"userId\":%@,\"bubbleIds\":[%@],\"av\":\"5\",\"ct\":\"ios\"}],\"disableLimitView\":true},\"callbackId\":\"rpc_15105601282960.%@\"}] ",bID,userID,timeStamp,userID,randNum,userID,bID,randNum];
    NSString *arg2=[NSString stringWithFormat:@"https://60000002.h5app.alipay.com/app/src/home.html?userId=%@",userID];
    PSDJsBridge *jsB=mbrige;
    [jsB _doFlushMessageQueue:arg1 url:arg2];
    
}


+(void)getTopUserBubbles:(id)mbrige userId:(NSString*)userID
{
    
    
    long timems=[[NSDate  date] timeIntervalSince1970]*1000;
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", timems];
    NSString *randNum=[H5WebViewController getNumberRandom:16];
    NSString *arg1=[NSString stringWithFormat:@"[{\"handlerName\":\"remoteLog\",\"data\":{\"seedId\":\"ANTFOREST-PAGE-READY-home\",\"param1\":\"shareBiz=none^type=behavior^currentTimestamp=1510628822616\",\"param2\":\"monitor_type=openPage^remoteType=info\",\"bizType\":\"antForest\"},\"callbackId\":\"remoteLog_15106288226220.36025243042968214\"},{\"handlerName\":\"getSystemInfo\",\"data\":{},\"callbackId\":\"getSystemInfo_15106288226230.7224089596420527\"},{\"handlerName\":\"hideOptionMenu\",\"data\":{},\"callbackId\":\"hideOptionMenu_15106288226230.7351219072006643\"},{\"handlerName\":\"setToolbarMenu\",\"data\":{\"menus\":[],\"override\":true},\"callbackId\":\"setToolbarMenu_15106288226230.6259752095211297\"},{\"handlerName\":\"setGestureBack\",\"data\":{\"val\":true},\"callbackId\":\"setGestureBack_15106288226230.2139696276281029\"},{\"handlerName\":\"remoteLog\",\"data\":{\"seedId\":\"ANTFOREST-H5_PAGE_SET_PAGE_NAME\",\"param1\":\"shareBiz=none^type=behavior^currentTimestamp=%@\",\"param2\":\"monitor_type=clicked^remoteType=info^pageName=home.html\",\"bizType\":\"antForest\"},\"callbackId\":\"remoteLog_15106288226260.2301180271897465\"},{\"handlerName\":\"addNotifyListener\",\"data\":{\"name\":\"NEBULANOTIFY_AFRefresh\"},\"callbackId\":\"addNotifyListener_15106288226260.7617499728221446\"},{\"handlerName\":\"rpc\",\"data\":{\"operationType\":\"alipay.antmember.forest.h5.queryNextAction\",\"requestData\":[{\"userId\":\"%@\",\"av\":\"5\",\"ct\":\"ios\"}],\"disableLimitView\":true},\"callbackId\":\"rpc_15106288226260.%@\"}]",timeStamp,userID,randNum];
    
    NSString *arg2=[NSString stringWithFormat:@"https://60000002.h5app.alipay.com/app/src/home.html?userId=%@",userID];
    PSDJsBridge *jsB=mbrige;
    //查询当前用户的能量
    [jsB _doFlushMessageQueue:arg1 url:arg2];
}

//获取当前时间戳
+(NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}



+(void)collectTopBub
{
    APListData *jdata=[APListData sharedInstance];
    
    NSMutableDictionary *copyDic=[jdata.topBubblesDic mutableCopy];
    
    //读取本地保存的能量球
    NSArray * bubbles = [Bubble bg_findAll:@"Bubble"];
    
    NSLog(@"(%d)个气泡等待采集= %@",(int)[bubbles count],bubbles);

    if([bubbles count]<1)
    {
        int count = 0;
        showMessageWithFrameY(@"本来已无能量数据", 4, 16,150);
        NSArray * finfAlls = [Friend bg_findAll:@"Friend"];
        
        for(Friend *fd in finfAlls)
        {
            NSString *userID=[fd userId];
            //获取用户的bubbles
            [H5WebViewController getTopUserBubbles:jdata.jsBridge userId:userID];
            NSLog(@"这是第%d波用户获取能量",count);
            count++;
            [NSThread sleepForTimeInterval:0.1];
        }

    }
    
    for (Bubble * obj in bubbles) {
        
        NSLog(@"bubble--userId=(%@);bID=(%@)",obj.userId,obj.bID);
        
        NSString *collectStatus=[obj collectStatus];
        int canHelpCollect = (int)[obj canHelpCollect];
        
        
        NSString *bID=[obj bID];
        NSString *uID=[obj userId];
        
        //可收集的 或 可帮助收取的
        if([collectStatus isEqualToString:@"AVAILABLE"] || ([obj produceTime] >= [[H5WebViewController currentTimeStr] longLongValue]))
        {
            showMessageWithFrameY(@"正在收取能量", 4, 16,150);

            [H5WebViewController collectBubbles:jdata.jsBridge bubbleId:bID userId:uID];
            NSLog(@"我开始收能量了--:%@",bID);
            //从数据库删除当前能量气泡
            /**
             按条件删除.
             */
            NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bID"),bg_sqlValue(bID)];
            NSLog(@"AVAILABLE--删除--bubble--（%@）",bID);
            [Bubble bg_delete:@"Bubble" where:where];
            
        }
        else if(canHelpCollect==1)
        {
            
            [H5WebViewController helpCollectBubbles:jdata.jsBridge bubbleId:bID userId:uID];
            NSLog(@"我开始帮他收能量了--:%@",bID);
            //从数据库删除当前能量气泡
            /**
             按条件删除.
             */
            NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bID"),bg_sqlValue(bID)];
            NSLog(@"canHelpCollect--删除--bubble--（%@）",bID);
            [Bubble bg_delete:@"Bubble" where:where];

        }
        else
        {
            if([obj produceTime] - [[H5WebViewController currentTimeStr] longLongValue]<0)
            {
                NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bID"),bg_sqlValue(bID)];
                NSLog(@"canHelpCollect--删除过期--bubble--（%@）",bID);
                [Bubble bg_delete:@"Bubble" where:where];
            }
            NSLog(@"不可收取(ID=%@);(%lld)-(%lld)=(%lld)",obj.bID,[obj produceTime],[[H5WebViewController currentTimeStr] longLongValue],[obj produceTime] - [[H5WebViewController currentTimeStr] longLongValue]);
        }
        
    }
}

//浇水
+(void)waterTreeWithUserId:(NSString*)userID
{
    APListData *jdata=[APListData sharedInstance];

    //浇水三次
    for(int i=0; i<3; i++)
    {
        long timems=[[NSDate  date] timeIntervalSince1970]*1000;
        NSString *timeStamp = [NSString stringWithFormat:@"%ld", timems];
        NSString *randNum=[H5WebViewController getNumberRandom:16];
        
        NSString *arg1=[NSString stringWithFormat:@"[{\"handlerName\":\"remoteLog\",\"data\":{\"seedId\":\"ANTFOREST-BEHAVIOR-CLICK-WATER\",\"param1\":\"shareBiz=none^type=behavior^currentTimestamp=%@\",\"param2\":\"monitor_type=clicked^remoteType=info^pageName=home.html^pageState=friend%@_enterhomeOff\",\"bizType\":\"antForest\"},\"callbackId\":\"remoteLog_15386245793000.%@\"}]",timeStamp,userID,randNum];
        
        NSString *url_1=[NSString stringWithFormat:@"https://60000002.h5app.alipay.com/app/src/home.html?userId=%@",userID];
        
        PSDJsBridge *jsB=jdata.jsBridge;
        
        NSLog(@"waterTreeWithUserId---jsbB = (%@)",jsB);
        
        long timems2=[[NSDate  date] timeIntervalSince1970]*1000;
        NSString *timeStamp2 = [NSString stringWithFormat:@"%ld", timems2];
        NSString *randNum2 = [H5WebViewController getNumberRandom:16];
        //
        NSString *arg2=[NSString stringWithFormat:@"[{\"handlerName\":\"rpc\",\"data\":{\"operationType\":\"alipay.antmember.forest.h5.transferEnergy\",\"requestData\":[{\"targetUser\":\"%@\",\"transferType\":\"WATERING\",\"bizNo\":\"2b05624b-330d-47ac-a22c-0713a204567a-%@\",\"av\":\"5\",\"ct\":\"ios\"}],\"disableLimitView\":true},\"callbackId\":\"rpc_15386245793050.%@\"}]",userID,timeStamp2,randNum2];
        
        [jsB _doFlushMessageQueue:arg2 url:url_1];
        
        [NSThread sleepForTimeInterval:0.1];
        
        [jsB _doFlushMessageQueue:arg1 url:url_1];
        
        [NSThread sleepForTimeInterval:0.2];

    }
    
    
    
    
}


@end
