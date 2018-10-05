

//读取本地保存的信息
static NSMutableArray * readWaterFriendListFromFile()
{
    NSMutableArray * array =[NSMutableArray arrayWithContentsOfFile:WaterFriendListPath];
    NSLog(@"waterFriendList=(%@)",array);
    return array;
}

//保存信息到本地
static bool saveWaterFriendListToFile(NSString *userid)
{
    NSMutableArray * theArray = readWaterFriendListFromFile();
    
    if(!theArray)
    {
        theArray = [[NSMutableArray alloc] init];
    }
    
    BOOL isExist = NO;
    
    for(NSString * tmpId in theArray)
    {
        if([tmpId isEqualToString:userid])
        {
            isExist = YES;
            break;
        }
    }
    
    if(!isExist)
    {
        NSLog(@"waterFriendList---add---userid=(%@)",userid);
        [theArray addObject:userid];
        
        BOOL res = [theArray writeToFile:WaterFriendListPath atomically:NO];
        
        return res;
    }
    
    return NO;
    
}


static NSString * handleCurrentFriendUserIdWithStr(NSString * str)
{
    //:[{"handlerName":"pushWindow","data":{"url":"home.html?userId=2088502064090631","param":{"transparentTitle":"auto","canPullDown":"NO","backgroundColor":86144}},"callbackId":"pushWindow_15386728183380.7476359980646521"}] url:https://60000002.h5app.alipay.com/app/src/listRank.html]
    
    
    if(str && [str containsString:@"[{\"handlerName\":\"pushWindow\",\"data\":{\"url\":\"home.html?userId="])
    {
        NSArray * strArray = [str componentsSeparatedByString:@"\",\"param\""];
        
        if(strArray && strArray.count>0)
        {
            
        }
        
        NSString * usid = [strArray[0] stringByReplacingOccurrencesOfString:@"[{\"handlerName\":\"pushWindow\",\"data\":{\"url\":\"home.html?userId=" withString:@""];
        
        if(usid)
        {
            NSLog(@"usid----=(%@)",usid);
            return usid;
        }
    }
    
    return nil;
    
}


@interface DTRpcOperation

- (id)initWithURL:(id)arg1 method:(id)arg2 params:(id)arg3 headerFields:(id)arg4 amrpc:(BOOL)arg5 cdn:(BOOL)arg6;

- (void)start;

@end




