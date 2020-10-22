//
//  HCLViewController.m
//  CLKitHelp
//
//  Created by hongcl8114@hotmail.com on 10/19/2020.
//  Copyright (c) 2020 hongcl8114@hotmail.com. All rights reserved.
//

#import "HCLViewController.h"

@interface HCLViewController ()

@end

@implementation HCLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = CLRandomColor;
//    CLLogString(@"测试打印");
    NSDate *date = [NSDate date];
    CLLogString([date dateByAddingMonths:2].dateymdhmsString);
    CLLogBool([date isInFuture]);
    CLLogInteger(date.week);
    CLLogInteger(date.weekday);
    CLLogString(date.dateymdhmsString);
    UIButton *btn = [UIButton new];
    [btn clKit_SetImagePoint:ButtonImageLocationTop andPadding:10];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
