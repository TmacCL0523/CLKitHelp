//
//  HCLViewController.m
//  CLKitHelp
//
//  Created by hongcl8114@hotmail.com on 10/19/2020.
//  Copyright (c) 2020 hongcl8114@hotmail.com. All rights reserved.
//

#import "HCLViewController.h"
#import <CLKitHelp.h>

@interface HCLViewController ()

@end

@implementation HCLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = CLRandomColor;
    CLLogString(@"测试打印");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
