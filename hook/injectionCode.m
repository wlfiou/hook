//
//  injectionCode.m
//  hook
//
//  Created by 王鹭飞 on 2018/12/25.
//  Copyright © 2018 王鹭飞. All rights reserved.
//

#import "injectionCode.h"
#import <objc/runtime.h>
@implementation injectionCode
IMP (*old_tz)(id self,SEL _cmd);
+(void)load{
    [self replaceMethodToHook];
//   [self getAndSetTohook];
}
+(void)replaceMethodToHook{
    Method ViewController_tz = class_getInstanceMethod(objc_getClass("ViewController"), @selector(tz));
    old_tz = method_getImplementation(ViewController_tz);
    //replace 会在没有函数的时候自己创建一个新的函数
    class_replaceMethod(objc_getClass("ViewController"), @selector(tz), my_tz, "v@:");
}
+(void)getAndSetTohook{
    Method ViewController_tz = class_getInstanceMethod(objc_getClass("ViewController"), @selector(tz));
    old_tz = method_getImplementation(ViewController_tz);
    method_setImplementation(ViewController_tz, (IMP)my_tz);
}
void my_tz(id self,SEL _cmd){
    NSLog(@"截获了跳转事件");
    old_tz(self,_cmd);
}

@end
