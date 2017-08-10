//
//  ViewController.m
//  Sample
//
//  Created by 徐佳良 on 16/11/16.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "ViewController.h"
#import "CustomerVIewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)doAction:(id)sender {
    
    CustomerVIewController *ctrl = [[CustomerVIewController alloc] initWithURI:[NSURL URLWithString:@"douban://douban.com/rexxar_demo?prod=nativedebug"]];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
