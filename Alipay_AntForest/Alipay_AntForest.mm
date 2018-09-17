#line 1 "/Users/king/Desktop/ChiJi/alipay/蚂蚁森林收取能量/Alipay_AntForest/Alipay_AntForest/Alipay_AntForest.xm"


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

#import <substrate.h>
#import <sys/sysctl.h>
static int (*orig_ptrace) (int request, pid_t pid, caddr_t addr, int data);

static int my_ptrace (int request, pid_t pid, caddr_t addr, int data){
if(request == 31){
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
static __attribute__((constructor)) void _logosLocalCtor_65c747d9(int __unused argc, char __unused **argv, char __unused **envp){
MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"),(void*)my_ptrace,(void**)&orig_ptrace);
NSLog(@"[AntiAntiDebug] Module loaded!!!");

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

@class PSDJsBridge; @class H5WebViewController; @class AUToast; 
static void (*_logos_orig$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$)(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id, id); static id (*_logos_orig$_ungrouped$PSDJsBridge$transformResponseData$)(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$PSDJsBridge$transformResponseData$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$H5WebViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$H5WebViewController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$_ungrouped$H5WebViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL, _Bool); static void _logos_method$_ungrouped$H5WebViewController$clickBtn(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$H5WebViewController$goToCollectBubbles(_LOGOS_SELF_TYPE_NORMAL H5WebViewController* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$AUToast(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("AUToast"); } return _klass; }
#line 55 "/Users/king/Desktop/ChiJi/alipay/蚂蚁森林收取能量/Alipay_AntForest/Alipay_AntForest/Alipay_AntForest.xm"



static void _logos_method$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {

HBLogDebug(@"-[<PSDJsBridge: %p> _doFlushMessageQueue:%@ url:%@]", self, arg1, arg2);
_logos_orig$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$(self, _cmd, arg1, arg2);

}




static id _logos_method$_ungrouped$PSDJsBridge$transformResponseData$(_LOGOS_SELF_TYPE_NORMAL PSDJsBridge* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {

HBLogDebug(@"-[<PSDJsBridge: %p> transformResponseData:%@]", self, arg1);
NSLog(@"arg1--type=(%@)\n",[arg1 class]);


id r = _logos_orig$_ungrouped$PSDJsBridge$transformResponseData$(self, _cmd, arg1);

HBLogDebug(@"transformResponseData--return = %@", r);

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
}


for(NSDictionary * dic in friendRanking)
{
if([dic[@"canCollectEnergy"] intValue]==1 || [dic[@"canHelpCollect"] intValue]==1 || [dic[@"userId"] isEqualToString:myself_userid])
{
BOOL isExist = NO;
for(NSDictionary * fdic in jdata.topFriends)
{
if([fdic[@"userId"] isEqualToString:dic[@"userId"]])
{
isExist = YES;
break;
}
}
if(!isExist)
{

[jdata.topFriends addObject:dic];
}
}

}

NSLog(@"好友排名个数=（%d）",(int)[jdata.topFriends count]);

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


NSLog(@"transformResponseData----6.1");

NSLog(@"发现能量了---------%@",userbubbles);
NSDictionary *dicbulles=[userbubbles objectAtIndex:0];
NSString *userID=[dicbulles objectForKey:@"userId"];

[jdata.topBubblesDic setObject:userbubbles forKey:userID];
NSLog(@"get--bubbles--%@",userID);
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

btView.startBlock = ^(){[self clickBtn];};

NSLog(@"do--addsubview---MyAutoTimerView");
[show addSubview:btView];
}

}


return;


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

for(NSDictionary *key in jdata.topFriends)
{
NSDictionary *dic2=key;
NSString *userID=[dic2 objectForKey:@"userId"];

[H5WebViewController getTopUserBubbles:jdata.jsBridge userId:userID];
NSLog(@"这是第%d波用户获取能量",count);
count++;
[NSThread sleepForTimeInterval:0.1];
}




dispatch_async(dispatch_get_global_queue(0, 0), ^{

[NSThread sleepForTimeInterval:0.5];
dispatch_async(dispatch_get_main_queue(), ^{


[H5WebViewController collectTopBub];
NSLog(@"game---over--title--正在收取能量--2");


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







static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$PSDJsBridge = objc_getClass("PSDJsBridge"); MSHookMessageEx(_logos_class$_ungrouped$PSDJsBridge, @selector(_doFlushMessageQueue:url:), (IMP)&_logos_method$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$, (IMP*)&_logos_orig$_ungrouped$PSDJsBridge$_doFlushMessageQueue$url$);MSHookMessageEx(_logos_class$_ungrouped$PSDJsBridge, @selector(transformResponseData:), (IMP)&_logos_method$_ungrouped$PSDJsBridge$transformResponseData$, (IMP*)&_logos_orig$_ungrouped$PSDJsBridge$transformResponseData$);Class _logos_class$_ungrouped$H5WebViewController = objc_getClass("H5WebViewController"); MSHookMessageEx(_logos_class$_ungrouped$H5WebViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$H5WebViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$H5WebViewController$viewDidLoad);MSHookMessageEx(_logos_class$_ungrouped$H5WebViewController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$H5WebViewController$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$H5WebViewController$viewDidAppear$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(clickBtn), (IMP)&_logos_method$_ungrouped$H5WebViewController$clickBtn, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$H5WebViewController, @selector(goToCollectBubbles), (IMP)&_logos_method$_ungrouped$H5WebViewController$goToCollectBubbles, _typeEncoding); }} }
#line 366 "/Users/king/Desktop/ChiJi/alipay/蚂蚁森林收取能量/Alipay_AntForest/Alipay_AntForest/Alipay_AntForest.xm"
