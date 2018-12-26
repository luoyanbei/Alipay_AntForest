#line 1 "/Volumes/WangJun/文件/0工作/Alipay_AntForest-master/Alipay_AntForest/Alipay_AntForest.xm"


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


BOOL isFirstDoStartRequest=YES;

BOOL isGainAllUserInfo = NO;

BOOL isExecuteCollect = NO;


NSString * myself_userid=nil;

AUToast *progressView=nil;

MyAutoTimerView * btView=nil;

NSString * currentFriendUserID = nil;




static __attribute__((constructor)) void _logosLocalCtor_8b131269(int __unused argc, char __unused **argv, char __unused **envp){
MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"),(void*)my_ptrace,(void**)&orig_ptrace);
NSLog(@"[AntiAntiDebug] Module loaded!!!");


NSString *homePath = NSHomeDirectory();
NSLog(@"home根目录:%@", homePath);






NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
NSLog(@"documens路径:%@", documentPath);



}



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class AUToast; @class H5WebViewController; @class PSDJsBridge; 
static void (*_logos_orig$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$)(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$PSDJsBridge$saveFriendsInfo$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, NSArray *); static void _logos_method$_ungrouped$PSDJsBridge$saveBubblesInfo$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, NSArray *); static id (*_logos_orig$_ungrouped$PSDJsBridge$transformResponseData$)(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$PSDJsBridge$transformResponseData$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$H5WebViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$H5WebViewController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$_ungrouped$H5WebViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$_ungrouped$H5WebViewController$btnAddWaterClick(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$bluewaterBtnClick(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$clickBtn(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$goToCollectBubbles(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$collectEnergy(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$AUToast(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("AUToast"); } return _klass; }
#line 83 "/Volumes/WangJun/文件/0工作/Alipay_AntForest-master/Alipay_AntForest/Alipay_AntForest.xm"



static void _logos_method$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
NSLog(@"_doFlushMessageQueue---arg1.class=(%@);arg2.class=(%@)",[arg1 class],[arg2 class]);


if(arg1!=nil&&[arg1 isKindOfClass:[NSString class]] && [arg1 containsString:@"[{\"handlerName\":\"pushWindow\",\"data\":{\"url\":\"home.html?userId="])
{


NSLog(@"currentFriendUserID---receive---1");
currentFriendUserID = [handleCurrentFriendUserIdWithStr(arg1) mutableCopy];
NSLog(@"currentFriendUserID---receive---1--currentFriendUserID=(%@)",currentFriendUserID);

}



HBLogDebug(@"-[<PSDJsBridge: %p> _doFlushMessageQueue:%@ url:%@]", self, arg1, arg2);

_logos_orig$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$(self, _cmd, arg1, arg2);

}




static void _logos_method$_ungrouped$PSDJsBridge$saveFriendsInfo$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSArray * array) {
    for(int i=0; i< [array count]; i++)
    {
        Friend * f = [Friend creatWithDic:array[i]];
        [f bg_saveOrUpdate];
    }
}




static void _logos_method$_ungrouped$PSDJsBridge$saveBubblesInfo$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSArray * array) {
    for(int i=0; i< [array count]; i++)
    {
        Bubble * b = [Bubble creatWithDic:array[i]];
        [b bg_saveOrUpdate];
    }
}





static id _logos_method$_ungrouped$PSDJsBridge$transformResponseData$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {

HBLogDebug(@"-[<PSDJsBridge: %p> transformResponseData:%@]", self, arg1);


NSLog(@"transformResponseData---arg1--type=(%@)\n",[arg1 class]);




NSLog(@"transformResponseData---arg1=(%@)\n",arg1);




id r = _logos_orig$_ungrouped$PSDJsBridge$transformResponseData$(self, _cmd, arg1);



NSLog(@"transformResponseData----0");

APListData *jdata=[APListData sharedInstance];

jdata.jsBridge=self;

if(!isExecuteCollect)
{
return r;
}



if(arg1!=nil&&[arg1 isKindOfClass:[NSDictionary class]])
{


NSDictionary *dic=arg1;
NSLog(@"transformResponseData----1");

id friendRanking=[dic objectForKey:@"friendRanking"];

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


[self saveFriendsInfo:friendRanking];




if([dic[@"hasMore"] intValue]==0)
{
    NSLog(@"transformResponseData----3");
    
    NSLog(@"已收集全部可收集的好友=%@",jdata.topFriends);
    if(progressView)
    {
        [progressView dismissToast];
        progressView=nil;
        NSLog(@"game---over---查询好友排行榜");

    }

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goToCollectBublles" object:nil];

}
else
{
    NSLog(@"transformResponseData----4");
    
    
    int nextPoint = [dic[@"nextStartPoint"] intValue];
    NSLog(@"加载更多好友信息---%d",nextPoint);

    [H5WebViewController getListRankingWithStartPoint:nextPoint];
}

NSLog(@"transformResponseData----5");

}


id userbubbles=[dic objectForKey:@"bubbles"];

if(userbubbles)
{
NSLog(@"transformResponseData----6");

if(![userbubbles isKindOfClass:[NSArray class]]||[userbubbles count]<=0)
return r;


[self saveBubblesInfo:userbubbles];

NSLog(@"transformResponseData----6.1");

}

NSLog(@"transformResponseData----7");

}

return r;

}









static void _logos_method$_ungrouped$H5WebViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
_logos_orig$_ungrouped$H5WebViewController$viewDidLoad(self, _cmd);

APListData *jdata=[APListData sharedInstance];
jdata.topBubblesDic=[[NSMutableDictionary alloc] init];

isFirstDoStartRequest = YES;

}


static void _logos_method$_ungrouped$H5WebViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1) {

_logos_orig$_ungrouped$H5WebViewController$viewDidAppear$(self, _cmd, arg1);
UILabel *showlb=[self webviewDomainLabel];

if ([showlb.text rangeOfString:@"60000002.h5app.alipay.com"].location != NSNotFound)
{
UIButton *btnAdd=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 150, 80, 40)];
[btnAdd setTitle:@"一键收取" forState:UIControlStateNormal];
btnAdd.titleLabel.font = [UIFont systemFontOfSize: 15.0];
[btnAdd addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
[btnAdd setBackgroundColor:[UIColor orangeColor]];

UIWebView *show=[self h5WebView];

[show addSubview:btnAdd];

if(!btView)
{

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

UIButton *btnAddWater=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 300, 80, 40)];
[btnAddWater setTitle:@"加入浇水" forState:UIControlStateNormal];
btnAddWater.font = [UIFont systemFontOfSize:15.0];
[btnAddWater addTarget:self action:@selector(btnAddWaterClick) forControlEvents:UIControlEventTouchUpInside];
[btnAddWater setBackgroundColor:TheBlueColor];

[show addSubview:btnAddWater];





}


return;


}




static void _logos_method$_ungrouped$H5WebViewController$btnAddWaterClick(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
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



static void _logos_method$_ungrouped$H5WebViewController$bluewaterBtnClick(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

NSLog(@"waterTree---do---1");

if(progressView==nil)
progressView=[_logos_static_class_lookup$AUToast() presentToastWithText:@"正在为好友浇水" logTag:@"1"];

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




static void _logos_method$_ungrouped$H5WebViewController$clickBtn(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

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
progressView=[_logos_static_class_lookup$AUToast() presentToastWithText:@"查询好友排行榜" logTag:@"1"];


[H5WebViewController getListRankingWithStartPoint:0];



[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToCollectBubbles) name:@"goToCollectBublles" object:nil];

[NSThread sleepForTimeInterval:0.1];

}




static void _logos_method$_ungrouped$H5WebViewController$goToCollectBubbles(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {


if(progressView==nil)
{
progressView=[_logos_static_class_lookup$AUToast() presentToastWithText:@"正在收取能量" logTag:@"1"];
NSLog(@"game---over--title--正在收取能量");

}


APListData *jdata=[APListData sharedInstance];

NSLog(@"do--goToCollectBubbles");

int count=1;




NSArray * finfAlls = [Friend bg_findAll:@"Friend"];

for(Friend *fd in finfAlls)
{
NSString *userID=[fd userId];

[H5WebViewController getTopUserBubbles:jdata.jsBridge userId:userID];
NSLog(@"这是第%d波用户获取能量",count);
count++;
[NSThread sleepForTimeInterval:0.1];
}




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



static void _logos_method$_ungrouped$H5WebViewController$collectEnergy(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

showMessageWithFrameY(@"正在收取能量", 4, 16,150);

NSLog(@"do--collectEnergy--1");

[H5WebViewController collectTopBub];

}






static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$PSDJsBridge = objc_getClass("PSDJsBridge"); MSHookMessageEx(_logos_class$_ungrouped$PSDJsBridge, @selector(_doFlushMessageQueue:url:), (IMP)&_logos_method$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$, (IMP*)&_logos_orig$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSArray *), strlen(@encode(NSArray *))); i += strlen(@encode(NSArray *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$PSDJsBridge, @selector(saveFriendsInfo:), (IMP)&_logos_method$_ungrouped$PSDJsBridge$saveFriendsInfo$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSArray *), strlen(@encode(NSArray *))); i += strlen(@encode(NSArray *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$PSDJsBridge, @selector(saveBubblesInfo:), (IMP)&_logos_method$_ungrouped$PSDJsBridge$saveBubblesInfo$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$PSDJsBridge, @selector(transformResponseData:), (IMP)&_logos_method$_ungrouped$PSDJsBridge$transformResponseData$, (IMP*)&_logos_orig$_ungrouped$PSDJsBridge$transformResponseData$);Class _logos_class$_ungrouped$H5WebViewController = objc_getClass("H5WebViewController"); MSHookMessageEx(_logos_class$_ungrouped$H5WebViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$H5WebViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$H5WebViewController$viewDidLoad);MSHookMessageEx(_logos_class$_ungrouped$H5WebViewController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$H5WebViewController$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$H5WebViewController$viewDidAppear$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(btnAddWaterClick), (IMP)&_logos_method$_ungrouped$H5WebViewController$btnAddWaterClick, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(bluewaterBtnClick), (IMP)&_logos_method$_ungrouped$H5WebViewController$bluewaterBtnClick, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(clickBtn), (IMP)&_logos_method$_ungrouped$H5WebViewController$clickBtn, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(goToCollectBubbles), (IMP)&_logos_method$_ungrouped$H5WebViewController$goToCollectBubbles, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(collectEnergy), (IMP)&_logos_method$_ungrouped$H5WebViewController$collectEnergy, _typeEncoding); }} }
#line 500 "/Volumes/WangJun/文件/0工作/Alipay_AntForest-master/Alipay_AntForest/Alipay_AntForest.xm"
