//
//  MyAutoTimerView.m
//  Alipay_AntForest
//
//  Created by King on 2018/9/17.
//

#import "MyAutoTimerView.h"

#define SECONDS 10

@interface MyAutoTimerView()

@property(nonatomic,assign)int minutes;

@property(nonatomic,assign)BOOL status;

@property(nonatomic,strong)NSTimer * myTimer;

@property(nonatomic,assign)int seconds;


@end

@implementation MyAutoTimerView


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.frame = frame;
        self.backgroundColor = [UIColor redColor];
        
        float btnWidth = frame.size.width*0.5;
        float btnHeight = frame.size.height;
        
        _minutes = 10;
        _seconds = SECONDS;
        _status = NO;
        
        if(_minuteBtn==nil)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:[NSString stringWithFormat:@"%d秒",_seconds] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor redColor]];
            btn.frame = CGRectMake(0, 0, btnWidth, btnHeight);
            //[btn addTarget:self action:@selector(minuteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            _minuteBtn = btn;

            [self addSubview:_minuteBtn];
            
        }
        
        if(_startBtn==nil)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:_status?@"取消":@"定时" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor blueColor]];
            btn.frame = CGRectMake(btnWidth, 0, btnWidth, btnHeight);
            [btn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];

            _startBtn = btn;
            
            [self addSubview:_startBtn];
            
        }
        
    }
    
    return self;
}

-(void)startBtnClick:(UIButton *)btn
{
    NSLog(@"do--startBtnClick");
    self.status = !self.status;
    
    [btn setTitle:self.status?@"取消":@"定时收取" forState:UIControlStateNormal];
    
    if(self.status)
    {
        //分钟按钮设为不可点击
        [self.minuteBtn setUserInteractionEnabled:NO];
        
        self.seconds= SECONDS;
        
        if(!self.myTimer)
        {
            NSLog(@"do--newTimer");
            //开始计时
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerActionMethod) userInfo:nil repeats:YES];
            
            //[[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        }
        
    }
    else
    {
        //分钟按钮设为不可点击
        [self.minuteBtn setUserInteractionEnabled:YES];

        //取消计时
        if(self.myTimer)
        {
            [self.myTimer invalidate];
            self.myTimer = nil;
            self.seconds=0;
        }
    }

}

//定时器事件
-(void)timerActionMethod
{
    if(self.seconds>0)
    {
        self.seconds--;
        NSLog(@"do--seconds=%d",self.seconds);

    }
    else
    {
        NSLog(@"do--block--1");

        if(self.startBlock)
        {
            NSLog(@"do--block--2");
            _startBlock();
            self.seconds=SECONDS;

        }
        else
        {
            NSLog(@"do--block--invalid");
        }
        
    }
    
    
}

-(void)minuteBtnClick:(UIButton *)btn
{
    NSLog(@"do--minuteBtnClick");

    if(self.minutes<10)
    {
        self.minutes = 10;
    }
    else if(self.minutes<100)
    {
        self.minutes += 10;
    }
    else
    {
        self.minutes=1;
    }
    
    [btn setTitle:[NSString stringWithFormat:@"%d分",self.minutes] forState:UIControlStateNormal];
}


@end
