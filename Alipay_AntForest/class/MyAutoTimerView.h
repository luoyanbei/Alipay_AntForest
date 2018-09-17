//
//  MyAutoTimerView.h
//  Alipay_AntForest
//
//  Created by King on 2018/9/17.
//

#import <UIKit/UIKit.h>

typedef void (^startBtnClickBlock)();

@interface MyAutoTimerView : UIView

@property(nonatomic,strong)UIButton * startBtn;//开启定时按钮

@property(nonatomic,strong)UIButton * minuteBtn;//分钟按钮




@property(nonatomic,copy) startBtnClickBlock startBlock;

-(instancetype)initWithFrame:(CGRect)frame;

@end
