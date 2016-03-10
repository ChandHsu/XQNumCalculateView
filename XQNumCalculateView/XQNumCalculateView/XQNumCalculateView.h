//
//  XQNumCalculateView.h
//  各种自定义控件试用
//
//  Created by Apple on 16/3/10.
//  Copyright © 2016年 SJLX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    XQNumCalculateViewTypeBorderAll,
    XQNumCalculateViewTypeBorderEvery,
    XQNumCalculateViewTypeBorderOut
}XQNumCalculateViewBorderType;


typedef void(^XQNumCalculateViewChangeBlock)(int result);
@interface XQNumCalculateView : UIView


@property (nonatomic, assign) XQNumCalculateViewBorderType type;
/********   最大数量    *********/
@property (nonatomic, assign) int maxNum;
/********   最小数量    *********/
@property (nonatomic, assign) int minNum;
/********   开始数    *********/
@property (nonatomic, assign) int startNum;
/********   单位计算量    *********/
@property (nonatomic, assign) int unitNum;
/********   计算结果    *********/
@property (nonatomic, assign) int resultNum;
/********   计算回调  result:当前计算结果    *********/
@property (nonatomic, copy  ) XQNumCalculateViewChangeBlock changeBlock;

/********   边线颜色  默认蓝色  *********/
@property (nonatomic, strong) UIColor *numViewBorderColor;
/********   中间数字字体颜色 默认黑色   *********/
@property (nonatomic, strong) UIColor *numColor;
/********   加减按钮字体颜色   默认黑色 *********/
@property (nonatomic, strong) UIColor *calBtnTextColor;
/********   加减按钮字体高亮颜色   默认黑色 *********/
@property (nonatomic, strong) UIColor *calBtnHighTextColor;
/********   加减按钮字体不可用颜色   默认系统渲染 *********/
@property (nonatomic, strong) UIColor *calBtnDisabledTextColor;
/********   加减按钮背景色  默认白色*********/
@property (nonatomic, strong) UIColor *calBtnBgColor;
/********   加减按钮高亮背景色 默认灰色*********/
@property (nonatomic, strong) UIColor *calBtnHighBgColor;
/********   加减按钮字体不可用颜色   默认系统渲染 *********/
@property (nonatomic, strong) UIColor *calBtnDisabledBgColor;
/********   数字label的颜色 默认白色 *********/
@property (nonatomic, strong) UIColor *numLabelBgColor;
/********   加减按钮字体大小   默认系统 *********/
@property (nonatomic, strong) UIFont *calBtnTextFont;
/********   数字字体大小   默认系统 *********/
@property (nonatomic, strong) UIFont *numLabelTextFont;
/********   是否自动设置按钮enabled 默认True   *********/
@property (nonatomic, assign) BOOL autoEnableCal;

@end
