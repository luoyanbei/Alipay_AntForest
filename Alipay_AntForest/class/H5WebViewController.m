
#import "H5WebViewController.h"


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
    
    
    
    
 
+(void)collectBubbles:(id)mbrige bubbleId:(NSString*)bID userId :(NSString*)userID
{
    /*
     [<PSDJsBridge: 0x12983edd0> _doFlushMessageQueue:[{"handlerName":"remoteLog","data":{"seedId":"ANTFOREST-BEHAVIOR-CLICK-COLLECT","param1":"shareBiz=none^bubbleId=74259364^actionUserId=2088502616494973^type=behavior^currentTimestamp=1537023379730","param2":"monitor_type=clicked^remoteType=info^pageName=home.html^pageState=friend2088502616494973_enterhomeOff","bizType":"antForest"},"callbackId":"remoteLog_15370233797310.1787324680481106"}] url:https://60000002.h5app.alipay.com/app/src/home.html?userId=2088502616494973]
     
     */
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
 
 
+(void)collectTopBub
{
	 APListData *jdata=[APListData sharedInstance];
    
     NSMutableDictionary *copyDic=[jdata.topBubblesDic mutableCopy];
    
     NSLog(@"收集top10用户OK,开始一个个采集:%@",copyDic);

    
      for (id key in copyDic) {
            id obj = [copyDic objectForKey:key];

            NSLog(@"=========:%@=====:%@",key,obj);
            for(NSDictionary *eachbubble in obj){
            	 NSString *collectStatus=[eachbubble objectForKey:@"collectStatus"];
                 int canHelpCollect = [eachbubble[@"canHelpCollect"] intValue];
            	 //可收集的 或 可帮助收取的
                if([collectStatus isEqualToString:@"AVAILABLE"] || canHelpCollect==1)
                 {
                       NSString *bID=[eachbubble objectForKey:@"id"];
                       NSString *uID=[eachbubble objectForKey:@"userId"];
                       [H5WebViewController collectBubbles:jdata.jsBridge bubbleId:bID userId:uID];
                       NSLog(@"我开始收能量了--:%@",bID);

            	 }
            }
      }
  }


/*

-(void)startFirstLoadRequest:(NSURL *)url
{
 
    NSMutableURLRequest * v5 = [NSMutableURLRequest requestWithURL:url];
    
    id v8 = v7 = [NBLoadRequestEvent firstLoadRequestEvent:v5];

    v110 = v3 = self;
    
    id v9 = [self scene];
    
    [v9 dispatchEvent:v7];
    
    id v12 = v11 = [v7 request];
    
    id v112 = v14 = [v12 URL];
    
    id v17 = [v12 mutableCopy];

    id v20 = v19 = v18 = [v8 context];
    
    id v23 = v22 =v21 = [v19 currentViewController];
    
    id v26 = v25 = v24 = [v22 options];
    
    id v29 = v28 = v27 =[v25 pushingURLString];
    
    id v31 = sub_101FCFAC0(v28, (__int64)&stru_103A04FF0);
    
    if([v31 length])
    {
        [v17 setValue:v31 forHTTPHeaderField:@"Referer"];
    }
    
    v111 = v31;
    
    id v34 = v33 = v32 = [H5Configs sharedConfigs];
    
    id v36 = v35 = [v33 sinceIOS10InterceptConfig];
    
    NSString * v38 = @"none";
    
    if(v36)
    {
        v38 = v36;
    }
    
    v39 = v38;
    
    sub_1006FAA24(CFSTR("IOS10Intercept"), 20000LL, CFSTR("%@"));
    
    id v42 = v41 = [v112 absoluteString:v39];
    
    if(![v42 isEqualToString:@""])
    {
        v109 = v17;
        v45 = v44 = [self options];
        v50 = v48 = v47 = [v45 appId];
        if(! v48)
        {
            v48 = @"";
        }
        
        v51 = v48;
        
        v53 = v52 = [H5AliAutoLogin shared];
        v55 = v54 = v45;
        
        v56 = [v53 enableAliAutoLogin:v55];
        
        if(! v56)
        {
            v110 = self;
            [self doLoadRequest:v109];
        }
        
        v59 = v58 = v57 = [H5Configs sharedConfigs];
        
        v61 = v60 = [v58 aliAutoLoginSwitch];
        
        v63 = v62 = v59;
        
        v66 = [v63 aliAutoLoginWhiteList];
        
        v68 = [v66 containsObject:v51];
        
        v69 = @"NO";
        if(v68)
        {
            v69 = @"YES";
        }
        v70 = v69;
        
        sub_1006FAA24(CFSTR("H5_AL_SESSION_ALIAUTOLOGIN"), 20000LL, CFSTR("new=1^switch=%@^inWhitelist=%@"));
        
        v72 = [self options];
        
        v73 = (unsigned __int64)objc_msgSend(v72, "preSSOLogin", v61, v70);
        
        if(v73)
        {
            v75 = [self options];
            
            v78 = [v75 preSSOLoginUrl];
            
            if([v78 length])
            {
                v106 = 0;
            }
            else
            {
                v81 = [v112 absoluteString];
                v106 = 1;
                v78 = v81;
            }
            
            v83 = [NSURL URLWithFixedString:v78];
            
            if(v83)
            {
                v85 = [H5AliAutoLogin shared];
                
                if([v85 canAutologin:v83])
                {
                    v108 = (char *)v78;
                    v120 = CFSTR("H5AutoLoginUrl");
                    v88 = [v83 absoluteString];
                    v89 = v88;
                    if ( v88 )
                    {
                        v90 = (const __CFString *)v88;
                    }
                    else
                    {
                        v90 = "";
                    }
 
                    v122 = v90;
                    v121 = CFSTR("H5AutoLoginNeedBindingPage");
                    v92 = ((H5Options *(__cdecl *)(H5WebViewController *, SEL))objc_msgSend)(v110, "options");
                    v94 = [v92 preSSOLoginBindingPage];
                    
                    v96 = [NSNumber numberWithBool:v94];
                    v123 = v96;
                    
                    v98 = [NSDictionary dictionaryWithObjects:&v122 forKeys:&v120 count:2LL];
                    
                    v99 = [v98 mutableCopy];
                    
                    v101 = [self options];
                    
                    LODWORD(v93) = (unsigned __int64)objc_msgSend(v101, "preSSOLoginBindingPage");
                    objc_release(v101);
                    
                    if ( (_DWORD)v93 )
                        [v99 setObject:v110 forKeyedSubscript:"H5AutoLoginContextController"];
                    
                    v103 = [H5AliAutoLogin shared];
                    
                    v113 = _NSConcreteStackBlock;
                    v114 = 3254779904LL;
                    v115 = &sub_101FE3DAC;
                    v116 = &unk_10398AFB0;
                    v117 = objc_retain(v110, v104);
                    v119 = v106;
                    v17 = v109;
                    v118 = objc_retain(v109, v105);
                    objc_msgSend(v103, "autoLoginAsync:finished:", v99, &v113);
                }
            }
        }
        v17 = v109;
        [self doLoadRequest:v109];

        v79 = v107;
 
    }
 
}

 */


@end
