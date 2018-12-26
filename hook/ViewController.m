//
//  ViewController.m
//  hook
//
//  Created by 王鹭飞 on 2018/12/25.
//  Copyright © 2018 王鹭飞. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testArray];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)tz{
    TestViewController *vc = [TestViewController new];
    [self presentViewController:vc animated:vc completion:nil];
}
-(void)testArray{
    NSMutableArray *aa = [[NSMutableArray alloc]init];
    [aa addObject:nil];
}
-(void)testUrl{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/中"];
    NSLog(@"%@",url);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self testArray];
    [self tz];
}
@end
