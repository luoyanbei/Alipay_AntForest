// See http://iphonedevwiki.net/index.php/Logos

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import "NSDictionary+DLog.h"
#import "NSArray+DLog.h"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "H5WebViewController.h"
#import "APListData.h"
#import "PSDJsBridge.h"
#import "AUToast.h"
#import "Header.h"
#import "MyAutoTimerView.h"
#import "OCExpandableButton.h"

#import "Friend.h"
#import "Bubble.h"
#import <substrate.h>
#import <sys/sysctl.h>





static int (*orig_ptrace) (int request, pid_t pid, caddr_t addr, int data);

static int my_ptrace (int request, pid_t pid, caddr_t addr, int data)
{
if(request == 31)
{
NSLog(@"[AntiAntiDebug] - ptrace request is PT_DENY_ATTACH");
return 0;
}

return orig_ptrace(request,pid,addr,data);

}

#define CDUnknownBlockType id
@class DTRpcConfigManager,DTRpcMethod;

//悬浮按钮
OCExpandableButton * imgIcon;

//全局变量
BOOL isFirstDoStartRequest=YES;
//已获取全部用户信息
BOOL isGainAllUserInfo = NO;
//执行一键收集
BOOL isExecuteCollect = NO;

//我的id
NSString * myself_userid=nil;
//进度提示
AUToast *progressView=nil;
//定时view
MyAutoTimerView * btView=nil;
//当前好友的userid
NSString * currentFriendUserID = nil;

NSMutableArray *menuSubviews;


%ctor{
MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"),(void*)my_ptrace,(void**)&orig_ptrace);
NSLog(@"[AntiAntiDebug] Module loaded!!!");

//1.获取沙盒数据容器根目录
NSString *homePath = NSHomeDirectory();
NSLog(@"home根目录:%@", homePath);
//2.获取Documents路径
/*参数一：指定要搜索的文件夹枚举值
参数二：指定搜索的域Domian: NSUserDomainMask
参数三：是否需要绝对/全路径：NO：波浪线~标识数据容器的根目录; YES(一般制定): 全路径
*/

NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
NSLog(@"documens路径:%@", documentPath);



}


%hook PSDJsBridge

- (void)_doFlushMessageQueue:(id)arg1 url:(id)arg2
{
NSLog(@"_doFlushMessageQueue---arg1.class=(%@);arg2.class=(%@)",[arg1 class],[arg2 class]);

//获取当前好友的userid
if(arg1!=nil&&[arg1 isKindOfClass:[NSString class]] && [arg1 containsString:@"[{\"handlerName\":\"pushWindow\",\"data\":{\"url\":\"home.html?userId="])
{


NSLog(@"currentFriendUserID---receive---1");
currentFriendUserID = [handleCurrentFriendUserIdWithStr(arg1) mutableCopy];
NSLog(@"currentFriendUserID---receive---1--currentFriendUserID=(%@)",currentFriendUserID);

}



%log;

%orig;

}

%new
//存储好友信息
-(void)saveFriendsInfo:(NSArray *)array
{
    for(int i=0; i< [array count]; i++)
    {
        Friend * f = [Friend creatWithDic:array[i]];
        [f bg_saveOrUpdate];
    }
}

%new
//保存能量气泡
-(void)saveBubblesInfo:(NSArray *)array
{
    for(int i=0; i< [array count]; i++)
    {
        Bubble * b = [Bubble creatWithDic:array[i]];

        NSString *collectStatus=[b collectStatus];
        int canHelpCollect = (int)[b canHelpCollect];
        if(canHelpCollect==1 || (![collectStatus isEqualToString:@"INSUFFICIENT"] && ![collectStatus isEqualToString:@"ROBBED"]))
        [b bg_saveOrUpdate];
    }

    NSArray * bubbles = [Bubble bg_findAll:@"Bubble"];

    if(bubbles)
        showMessageWithFrameY([NSString stringWithFormat:@"收集了[ %d ]个气泡",(int)[bubbles count]], 4, 16,150);
}



//网络response信息转换
-(id)transformResponseData:(id)arg1
{

%log;


NSLog(@"transformResponseData---arg1--type=(%@)\n",[arg1 class]);
//  arg1--type=(__NSCFDictionary)

//if [arg1 allKeys]  containsObject:@""]）{

NSLog(@"transformResponseData---arg1=(%@)\n",arg1);

//}


id r = %orig;

//HBLogDebug(@"transformResponseData--return = %@", r);

NSLog(@"transformResponseData----0");

APListData *jdata=[APListData sharedInstance];

jdata.jsBridge=self;

if(!isExecuteCollect)//是否执行一键收集
{
//return r;//
}



if(arg1!=nil&&[arg1 isKindOfClass:[NSDictionary class]])
{

//获取top10的用户ID
NSDictionary *dic=arg1;
NSLog(@"transformResponseData----1");
//好友等级排名
id friendRanking=[dic objectForKey:@"friendRanking"];//是一个数组，数组中是字典元素

if([[dic objectForKey:@"myself"] objectForKey:@"userId"] && ![[[dic objectForKey:@"myself"] objectForKey:@"userId"] isEqualToString:@""])
{
myself_userid = [[[dic objectForKey:@"myself"] objectForKey:@"userId"] mutableCopy];
NSLog(@"myself_userid=(%@)",myself_userid);
}


if(friendRanking && [friendRanking isKindOfClass:[NSArray class]])
{
NSLog(@"transformResponseData----2");

if(jdata.topFriends == nil)
{
jdata.topFriends = [[NSMutableArray alloc] init];
NSLog(@"查询好友排行---初始化jdata.topFriends");
}

//存储好友排行信息
[self saveFriendsInfo:friendRanking];


//NSLog(@"好友排名个数=（%d）",(int)[jdata.topFriends count]);

if([dic[@"hasMore"] intValue]==0)
{
    NSLog(@"transformResponseData----3");
    //没有更多好友信息，执行收集工作
    NSLog(@"已收集全部可收集的好友=%@",jdata.topFriends);
    if(progressView)
    {
        [progressView dismissToast];
        progressView=nil;
        NSLog(@"game---over---查询好友排行榜");

    }

    //发送通知，goto获取气泡
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goToCollectBublles" object:nil];

}
else
{
    NSLog(@"transformResponseData----4");
    //加载更多好友信息
    //获取排行中的用户
    int nextPoint = [dic[@"nextStartPoint"] intValue];
    NSLog(@"加载更多好友信息---%d",nextPoint);

    [H5WebViewController getListRankingWithStartPoint:nextPoint];
}

NSLog(@"transformResponseData----5");

}

//获取用户自己的能量的ID
id userbubbles=[dic objectForKey:@"bubbles"];

if(userbubbles)
{
NSLog(@"transformResponseData----6--用户气泡=(%@)",userbubbles);

if(![userbubbles isKindOfClass:[NSArray class]]||[userbubbles count]<=0)
return r;

//保存能量气泡
[self saveBubblesInfo:userbubbles];

NSLog(@"transformResponseData----6.1");

}

//保存我自己的id
if([dic objectForKey:@"userEnergy"])
{
NSDictionary * user = [dic objectForKey:@"userEnergy"];
NSDictionary * myDic = @{@"userId":user[@"userId"],@"canCollectLaterTime":@"1",@"canCollectEnergy":@"1",@"canHelpCollect":@"1",@"collectableBubbleCount":@"2",@"displayName":user[@"displayName"]};
[self saveFriendsInfo:@[myDic]];
NSLog(@"保存我自己的id");

}

NSLog(@"transformResponseData----7");

}

return r;

}


%end



%hook H5WebViewController

- (void)viewDidLoad
{
%orig;

APListData *jdata=[APListData sharedInstance];
jdata.topBubblesDic=[[NSMutableDictionary alloc] init];

isFirstDoStartRequest = YES;

}

//初始化图标
%new
-(void)initIcon {
if(imgIcon==nil){
NSLog(@"initIcon---1");

NSMutableArray *subviews = [[NSMutableArray alloc] init];

NSArray * titles = @[@"收集好友",@"收集气泡",@"定时收取",@"加入浇水",@"清空浇水",@"执行浇水"];
NSLog(@"initIcon---2");

float btnWidth = 60.0;
float btnHeight = 40.0;

for(int i = 0; i < (int)[titles count]; i++)
{
UIButton *numberButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
numberButton.tag = i;
numberButton.backgroundColor = [UIColor clearColor];
[numberButton setTitle:[NSString stringWithFormat:@"%@", titles[i]] forState:UIControlStateNormal];
numberButton.titleLabel.textAlignment = NSTextAlignmentCenter;
[numberButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
[numberButton addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
[numberButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];

[subviews addObject:numberButton];
}

menuSubviews = subviews;

imgIcon = [[OCExpandableButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10-btnWidth, 66, btnWidth, btnWidth) subviews:subviews];

imgIcon.alignment = OCExpandableButtonAlignmentLeft;
NSLog(@"initIcon---4");

[[self view] addSubview:imgIcon];

}

UIWebView *show=[self h5WebView];

[show addSubview:imgIcon];

}

%new
//菜单点击事件
-(void)menuBtnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            [self clickBtn];
            break;
        case 1:
            [self goToCollectBubbles];
            break;
        case 2: {
            [btView startBtnClick:menuSubviews[2]];
            break;
        }

        case 3:
            [self btnAddWaterClick];//当前用户加入浇水队列
            break;
        case 4:
            [self btnClearWaterList];
            break;
        case 5:
            [self bluewaterBtnClick];
            break;
        default:
            break;
    }

}


- (void)viewDidAppear:(_Bool)arg1
{

%orig;
UILabel *showlb=[self webviewDomainLabel];

if ([showlb.text rangeOfString:@"60000002.h5app.alipay.com"].location != NSNotFound)
{

[self initIcon];

if(!btView)
{
//定时view
btView = [[MyAutoTimerView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 200, 80, 40)];

btView.startBlock = ^(){[self collectEnergy];};

NSLog(@"do--addsubview---MyAutoTimerView");
}


return;

UIButton *btnAdd=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 150, 80, 40)];
[btnAdd setTitle:@"一键收取" forState:UIControlStateNormal];
btnAdd.titleLabel.font = [UIFont systemFontOfSize: 15.0];
[btnAdd addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
[btnAdd setBackgroundColor:[UIColor orangeColor]];

UIWebView *show=[self h5WebView];

[show addSubview:btnAdd];

if(!btView)
{
//定时view
btView = [[MyAutoTimerView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 200, 80, 40)];

btView.startBlock = ^(){[self collectEnergy];};

NSLog(@"do--addsubview---MyAutoTimerView");
}

[show addSubview:btView];



UIButton *btnWater=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 250, 80, 40)];
[btnWater setTitle:@"一键浇水" forState:UIControlStateNormal];
btnWater.titleLabel.font = [UIFont systemFontOfSize: 15.0];
[btnWater addTarget:self action:@selector(bluewaterBtnClick) forControlEvents:UIControlEventTouchUpInside];
[btnWater setBackgroundColor:TheBlueColor];

[show addSubview:btnWater];
//添加当前好友到“浇水”
UIButton *btnAddWater=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 300, 80, 40)];
[btnAddWater setTitle:@"加入浇水" forState:UIControlStateNormal];
btnAddWater.font = [UIFont systemFontOfSize:15.0];
[btnAddWater addTarget:self action:@selector(btnAddWaterClick) forControlEvents:UIControlEventTouchUpInside];
[btnAddWater setBackgroundColor:TheBlueColor];

[show addSubview:btnAddWater];





}


return;


}

//把当前好友加入一键浇水中
%new
-(void)btnAddWaterClick
{
    NSLog(@"btnAddWaterClick---1");

    if(currentFriendUserID)
    {
        NSLog(@"btnAddWaterClick---2");


        BOOL result = saveWaterFriendListToFile(currentFriendUserID);
        NSString * message = result?@"添加成功":@"添加失败";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }

    NSLog(@"btnAddWaterClick---3");

}

%new
-(void)btnClearWaterList {

BOOL result = clearWaterFriendList();
NSString * message = result?@"清空成功":@"清空失败";
UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
[alert show];
}

//执行一键浇水
%new
-(void)bluewaterBtnClick
{

NSLog(@"waterTree---do---1");

if(progressView==nil)
progressView=[%c(AUToast) presentToastWithText:@"正在为好友浇水" logTag:@"1"];

NSMutableArray * friendArray = readWaterFriendListFromFile();
for(NSString * userid in friendArray)
{
if(userid && ![userid isEqualToString:@""])
{
[H5WebViewController waterTreeWithUserId:userid];
NSLog(@"waterTree---do---2---userid=(%@)",userid);

}
}
NSLog(@"waterTree---do---3");

if(progressView)
{
[progressView dismissToast];
progressView = nil;
NSLog(@"game---over---正在为好友浇水");
}


}


%new
- (void)clickBtn
{

NSLog(@"1-----------t1");

if(isExecuteCollect)
{
NSLog(@"1------isClickBtn---wait");
return;
}

isExecuteCollect = YES;


UIWebView *show=[self h5WebView];

APListData *jdata=[APListData sharedInstance];

NSLog(@"一键收取 click:%@---%@",jdata.jsBridge,[jdata.topFriends class]);
NSLog(@"game---over--title--查询好友排行榜");

if(progressView==nil)
progressView=[%c(AUToast) presentToastWithText:@"查询好友排行榜" logTag:@"1"];

//获取排行中的用户
[H5WebViewController getListRankingWithStartPoint:0];


//注册一个通知
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToCollectBubbles) name:@"goToCollectBublles" object:nil];
//[NSThread sleepForTimeInterval:0.1];

}

//收集能量气泡
%new
-(void)goToCollectBubbles
{


APListData *jdata=[APListData sharedInstance];

NSLog(@"do--goToCollectBubbles");
//获取每个用户的气泡
int count=1;

/**
同步查询所有数据.
*/
NSArray * finfAlls = [Friend bg_findAll:@"Friend"];


for(Friend *fd in finfAlls)
{
NSString *userID=[fd userId];
//获取用户的bubbles
[H5WebViewController getTopUserBubbles:jdata.jsBridge userId:userID];
NSLog(@"这是第%d波用户获取能量",count);
count++;
[NSThread sleepForTimeInterval:0.2];
}


return;

//等最后一波的回调结果
dispatch_async(dispatch_get_global_queue(0, 0), ^{

[NSThread sleepForTimeInterval:0.5];
dispatch_async(dispatch_get_main_queue(), ^{


NSLog(@"game---over--title--正在收取能量--2");
[self collectEnergy];

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
isExecuteCollect = NO;
if(progressView)
{
[progressView dismissToast];
progressView = nil;
NSLog(@"game---over---正在收取能量");
}
});

});

});

}

//收取能量
%new
-(void)collectEnergy {

NSLog(@"do--collectEnergy--1");
//开始收集全部能量
[H5WebViewController collectTopBub];

}

%end




