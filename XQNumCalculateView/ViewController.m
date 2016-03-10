//
//  ViewController.m
//  XQNumCalculateView
//
//  Created by Apple on 16/3/10.
//  Copyright © 2016年 SJLX. All rights reserved.
//

#import "ViewController.h"
#import "XQNumCalculateView.h"
#import "UIColor+Random.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    XQNumCalculateView *view1 = [[XQNumCalculateView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    view1.numViewBorderColor = [UIColor randomColor];
    [self.view addSubview:view1];
    
    view1.changeBlock = ^(int result){
        NSLog(@"%d",result);
    };
    
    
    view1.maxNum = 10;
    //    view1.minNum = 0;
    //    view1.unitNum = 2;
    //    view1.startNum = 3;
    view1.calBtnHighTextColor = [UIColor randomColor];
    view1.calBtnTextColor = [UIColor randomColor];
    view1.calBtnBgColor = [UIColor randomColor];
    view1.calBtnHighBgColor = [UIColor randomColor];
    
    
    XQNumCalculateView *view2 = [[XQNumCalculateView alloc] initWithFrame:CGRectMake(100, 140, 140, 30)];
    view2.numViewBorderColor = [UIColor randomColor];
    view2.type = XQNumCalculateViewTypeBorderEvery;
    [self.view addSubview:view2];
    view2.calBtnHighTextColor = [UIColor randomColor];
    view2.calBtnTextColor = [UIColor randomColor];
    view2.calBtnBgColor = [UIColor randomColor];
    view2.calBtnHighBgColor = [UIColor randomColor];
    
    XQNumCalculateView *view3 = [[XQNumCalculateView alloc] initWithFrame:CGRectMake(100, 180, 30, 100)];
    view3.numViewBorderColor = [UIColor randomColor];
    [self.view addSubview:view3];
    
    XQNumCalculateView *view4 = [[XQNumCalculateView alloc] initWithFrame:CGRectMake(170, 180, 30, 150)];
    view4.numViewBorderColor = [UIColor randomColor];
    [self.view addSubview:view4];
    view4.type = XQNumCalculateViewTypeBorderEvery;
    

}

@end
