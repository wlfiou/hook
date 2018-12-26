//
//  TestViewController.m
//  hook
//
//  Created by 王鹭飞 on 2018/12/26.
//  Copyright © 2018 王鹭飞. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *goBack = [UIButton buttonWithType:UIButtonTypeCustom];
    goBack.frame =CGRectMake(100, 100, 300, 300);
    [goBack setTitle:@"返回" forState:UIControlStateNormal];
    [goBack addTarget:self action:@selector(gogo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBack];
    // Do any additional setup after loading the view.
}
-(void)gogo:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
