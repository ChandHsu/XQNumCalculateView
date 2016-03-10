//
//  XQNumCalculateView.m
//  各种自定义控件试用
//
//  Created by Apple on 16/3/10.
//  Copyright © 2016年 SJLX. All rights reserved.
//

#import "XQNumCalculateView.h"



@interface UIImage (FromColor)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
#pragma mark - 华丽的分割线 *****************************************
@interface XQNumCalculateView ()

@property (nonatomic, strong) UIButton *subtractBtn;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel  *numLabel;

@end

@implementation XQNumCalculateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addControl];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addControl];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self addControl];
    }
    return self;
}
- (void)addControl{
    
    self.unitNum = 1;
    self.maxNum = 3;
    self.minNum = 1;
    self.autoEnableCal = true;
    
    self.subtractBtn = [self creatOneBtnWithTitle:@"-"];
    self.addBtn = [self creatOneBtnWithTitle:@"+"];
    
    self.subtractBtn.enabled = false;
    
    self.subtractBtn.tag = 0;
    self.addBtn.tag = 1;
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.backgroundColor = [UIColor whiteColor];
    self.numLabel.layer.borderColor = [UIColor blueColor].CGColor;
    self.numLabel.layer.borderWidth = 0.5f;
    [self addSubview:self.numLabel];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.text = @"1";
    
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = true;
    self.layer.shouldRasterize = true;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
}
- (UIButton *)creatOneBtnWithTitle:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.borderWidth = 0.5f;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.frame.size.width>=self.frame.size.height) {
        self.subtractBtn.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        self.addBtn.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        self.numLabel.frame = CGRectMake(self.subtractBtn.frame.size.width+5, 0, self.bounds.size.width - 2*(self.subtractBtn.frame.size.width+5), self.bounds.size.height);
    }else{
        self.subtractBtn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
        self.addBtn.frame = CGRectMake(0, self.frame.size.height - self.frame.size.width, self.bounds.size.width, self.bounds.size.width);
        self.numLabel.frame = CGRectMake(0, self.subtractBtn.frame.size.height+5, self.bounds.size.width, self.bounds.size.height - 2*(self.subtractBtn.frame.size.height+5));
    }
    
}
- (void)setNumViewBorderColor:(UIColor *)numViewBorderColor{
    _numViewBorderColor = numViewBorderColor;
    
    self.subtractBtn.layer.borderColor = numViewBorderColor.CGColor;
    self.addBtn.layer.borderColor = numViewBorderColor.CGColor;
    self.numLabel.layer.borderColor = numViewBorderColor.CGColor;
    self.layer.borderColor = numViewBorderColor.CGColor;
    
}
- (void)setNumColor:(UIColor *)numColor{
    _numColor = numColor;
    self.numLabel.textColor = numColor;
}
- (void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        if      (self.numLabel.text.intValue==self.minNum)              self.numLabel.text = self.numLabel.text;
        else if (self.numLabel.text.intValue-self.unitNum<self.minNum)  self.numLabel.text = [NSString stringWithFormat:@"%d",self.minNum];
        else    self.numLabel.text = [NSString stringWithFormat:@"%d",self.numLabel.text.intValue - self.unitNum];
        
        
        if (self.autoEnableCal) {
            if ([self.numLabel.text intValue] == self.minNum) self.subtractBtn.enabled = false;
            self.addBtn.enabled = true;
        }
        
    }else{
        
        if      (self.numLabel.text.intValue==self.maxNum)             self.numLabel.text = self.numLabel.text;
        else if (self.numLabel.text.intValue+self.unitNum>self.maxNum) self.numLabel.text = [NSString stringWithFormat:@"%d",self.maxNum];
        else    self.numLabel.text = [NSString stringWithFormat:@"%d",self.numLabel.text.intValue + self.unitNum];
        
        if (self.autoEnableCal) {
            if ([self.numLabel.text intValue] == self.maxNum)  self.addBtn.enabled = false;
            self.subtractBtn.enabled = true;
        }
    }
    
    if (self.changeBlock) {
        self.changeBlock(self.numLabel.text.intValue);
    }
    
    self.resultNum = self.numLabel.text.intValue;
    
}
- (void)setAutoEnableCal:(BOOL)autoEnableCal{
    _autoEnableCal = autoEnableCal;
    [self judgeBtnEnabled];
}
- (void)setStartNum:(int)startNum{
    _startNum = startNum;
    self.numLabel.text = [NSString stringWithFormat:@"%d",startNum];
    [self judgeBtnEnabled];
}
- (void)setMaxNum:(int)maxNum{
    _maxNum = maxNum;
    [self judgeBtnEnabled];
}
- (void)setMinNum:(int)minNum{
    _minNum = minNum;
    [self judgeBtnEnabled];
}
- (void)judgeBtnEnabled{
    if ([self.numLabel.text intValue] == self.minNum) {
        self.subtractBtn.enabled = false;
        self.addBtn.enabled = true;
    }else if ([self.numLabel.text intValue] == self.maxNum){
        self.subtractBtn.enabled = true;
        self.addBtn.enabled = false;
    }else{
        self.subtractBtn.enabled = true;
        self.addBtn.enabled = true;
    }
}
- (void)setCalBtnTextColor:(UIColor *)calBtnTextColor{
    _calBtnTextColor = calBtnTextColor;
    [self.subtractBtn setTitleColor:calBtnTextColor forState:UIControlStateNormal];
    [self.addBtn      setTitleColor:calBtnTextColor forState:UIControlStateNormal];
}
- (void)setCalBtnHighTextColor:(UIColor *)calBtnHighTextColor{
    _calBtnHighTextColor = calBtnHighTextColor;
    [self.subtractBtn setTitleColor:calBtnHighTextColor forState:UIControlStateHighlighted];
    [self.addBtn      setTitleColor:calBtnHighTextColor forState:UIControlStateHighlighted];
}
- (void)setCalBtnBgColor:(UIColor *)calBtnBgColor{
    _calBtnBgColor = calBtnBgColor;
    [self.subtractBtn setBackgroundImage:[UIImage imageWithColor:calBtnBgColor] forState:UIControlStateNormal];
    [self.addBtn      setBackgroundImage:[UIImage imageWithColor:calBtnBgColor] forState:UIControlStateNormal];
}
- (void)setCalBtnHighBgColor:(UIColor *)calBtnHighBgColor{
    _calBtnHighBgColor = calBtnHighBgColor;
    [self.subtractBtn setBackgroundImage:[UIImage imageWithColor:calBtnHighBgColor] forState:UIControlStateHighlighted];
    [self.addBtn      setBackgroundImage:[UIImage imageWithColor:calBtnHighBgColor] forState:UIControlStateHighlighted];
}
- (void)setCalBtnDisabledTextColor:(UIColor *)calBtnDisabledTextColor{
    _calBtnDisabledTextColor = calBtnDisabledTextColor;
    [self.subtractBtn setTitleColor:calBtnDisabledTextColor forState:UIControlStateDisabled];
    [self.addBtn      setTitleColor:calBtnDisabledTextColor forState:UIControlStateDisabled];
}
- (void)setCalBtnDisabledBgColor:(UIColor *)calBtnDisabledBgColor{
    _calBtnDisabledBgColor = calBtnDisabledBgColor;
    [self.subtractBtn setBackgroundImage:[UIImage imageWithColor:calBtnDisabledBgColor] forState:UIControlStateDisabled];
    [self.addBtn      setBackgroundImage:[UIImage imageWithColor:calBtnDisabledBgColor] forState:UIControlStateDisabled];
}
- (void)setType:(XQNumCalculateViewBorderType)type{
    _type = type;
    
    if (type == XQNumCalculateViewTypeBorderAll) {
        self.layer.borderColor = self.numViewBorderColor.CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius = 5.f;
    }else if(type == XQNumCalculateViewTypeBorderEvery){
        self.layer.cornerRadius = 0;
        self.layer.borderWidth = 0;
    }else{
        self.layer.borderColor = self.numViewBorderColor.CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius = 5.f;
        self.subtractBtn.layer.borderWidth = 0;
        self.addBtn.layer.borderWidth = 0;
        self.numLabel.layer.borderWidth = 0;
    }
    
}
- (void)setNumLabelBgColor:(UIColor *)numLabelBgColor{
    _numLabelBgColor = numLabelBgColor;
    self.numLabel.backgroundColor = numLabelBgColor;
}
- (void)setCalBtnTextFont:(UIFont *)calBtnTextFont{
    _calBtnTextFont = calBtnTextFont;
    self.subtractBtn.titleLabel.font = calBtnTextFont;
    self.addBtn.titleLabel.font = calBtnTextFont;
    
}
- (void)setNumLabelTextFont:(UIFont *)numLabelTextFont{
    _numLabelTextFont = numLabelTextFont;
    self.numLabel.font = numLabelTextFont;
}

@end
#pragma mark - 华丽的分割线 *****************************************
@implementation UIImage (FromColor)

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1,1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end


