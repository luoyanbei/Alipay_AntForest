

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

//提示信息
static void showMessageWithFrameY(NSString *message, NSTimeInterval tm, int fontSize,float theY)
{
    float screen_width = [UIScreen mainScreen].bounds.size.width;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 0.9f;
    //showview.layer.cornerRadius = 5.0f;
    //showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    
    float y_label=10;
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(MAXFLOAT, 9000)];
    
    int i=0;
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(10, 0, screen_width-2*10, LabelSize.height+10);
    label.lineBreakMode=UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    label.text = message;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    [showview addSubview:label];
    
    
    showview.frame = CGRectMake(0, theY, screen_width, LabelSize.height+14);
    
    dispatch_time_t time = dispatch_time ( DISPATCH_TIME_NOW , tm * NSEC_PER_SEC ) ;
    dispatch_after ( time , dispatch_get_main_queue ( ) , ^ {
        
        for(UILabel * tmp in showview.subviews){
            [tmp removeFromSuperview];
            //tmp=nil;
        }
        [showview removeFromSuperview];
        
    }) ;
    
    
}



@interface DTRpcOperation

- (id)initWithURL:(id)arg1 method:(id)arg2 params:(id)arg3 headerFields:(id)arg4 amrpc:(BOOL)arg5 cdn:(BOOL)arg6;

- (void)start;

@end




