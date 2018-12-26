//
//  NSURL+correctUrl.m
//  hook
//
//  Created by 王鹭飞 on 2018/12/26.
//  Copyright © 2018 王鹭飞. All rights reserved.
//

#import "NSURL+correctUrl.h"
#import <objc/runtime.h>
@implementation NSURL (correctUrl)
//OC 的方法Method 是一个结构体 看runtime.h 可知
/*
 struct objc_method {
 SEL _Nonnull method_name                                 OBJC2_UNAVAILABLE;
 char * _Nullable method_types                            OBJC2_UNAVAILABLE;
 IMP _Nonnull method_imp                                  OBJC2_UNAVAILABLE;
 }
 IMP 即为真正指向函数的指针，SEL是方法符号，底层交换其实是交换各个SEL 对于IMP的指向
 */
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method URLWithStr = class_getClassMethod(self, @selector(URLWithString:));
        
        Method HKURL = class_getClassMethod(self, @selector(HKURLWithStr:));
        
        //交换
        method_exchangeImplementations(URLWithStr, HKURL);
    });
}
+(instancetype)HKURLWithStr:(NSString *)str{
    //调用系统原来的方法
    NSURL * url = [NSURL HKURLWithStr:str];
    if (url == nil) {
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    url = [NSURL HKURLWithStr:str];
    
    return url;
}
@end
