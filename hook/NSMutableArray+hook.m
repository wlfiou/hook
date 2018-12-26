//
//  NSMutableArray+hook.m
//  hook
//
//  Created by 王鹭飞 on 2018/12/26.
//  Copyright © 2018 王鹭飞. All rights reserved.
//

#import "NSMutableArray+hook.h"
#import <objc/runtime.h>
@implementation NSMutableArray (hook)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc]init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(LFAddObject:)];
    });
    
}
-(void)LFAddObject:(id)obj{
    if (obj) {
        [self LFAddObject:obj];
    }else{
        NSLog(@"添加元素为nil");
    }
    
}
- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    //这里打印cls 可以看见是__NSArrayM  对于NSArray、NSMutableArray、NSDictionary、NSMutableDictionary等类进行swizzleMethod，不能直接使用类似NSClassFromString(@"NSMutableArray") 因为这些类簇类，其实是一种抽象工厂的设计模式。抽象工厂内部有很多其它继承自当前类的子类，抽象工厂类会根据不同情况，创建不同的抽象对象来进行使用
    //class 的获取一般使用 [self class] 或者 类似objc_getClass("__NSArrayM")取到真正的类
    Class cls = [self class];
//    Class cls = objc_getClass("__NSArrayM");
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
