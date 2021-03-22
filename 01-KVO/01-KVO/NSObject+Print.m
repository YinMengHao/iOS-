//
//  NSObject+Print.m
//  01-KVO
//
//  Created by MengHao Yin on 2021/3/22.
//

#import "NSObject+Print.h"
#import <objc/runtime.h>

@implementation NSObject (Print)

- (void)printMethodNamesOfClass:(Class)cls {
    [self printMethodNamesOfClass:cls className:nil];
}

- (void)printMethodNamesOfClass:(Class)cls className:(NSString * _Nullable)clsName {
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    NSMutableString *methodString = [NSMutableString string];
    for (int i = 0; i < count; i++) {
        //获取方法名
        Method method = methodList[i];
        //将方法名称转化成string，以便打印
        NSString *selName = NSStringFromSelector(method_getName(method));
        [methodString appendString: selName];
        [methodString appendString:@", "];
    }
    free(methodList);
    // 清空参数列表，并置参数指针args无效
    NSLog(@"%@ methodList = %@", clsName.length ? clsName : @"cls", methodString);
}

+ (void)printMethodNamesOfClass:(Class)cls {
    NSObject *obj = [self new];
    [obj printMethodNamesOfClass:cls];
}
 
+ (void)printMethodNamesOfClass:(Class)cls className:(NSString *)clsName {
    NSObject *obj = [self new];
    [obj printMethodNamesOfClass:cls className:clsName];
}
@end
