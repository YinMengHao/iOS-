//
//  NSObject+Print.h
//  01-KVO
//
//  Created by MengHao Yin on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Print)

///打印出cls中的方法, cls需要传入真实类型(object_getClass())
- (void)printMethodNamesOfClass:(Class)cls;
- (void)printMethodNamesOfClass:(Class)cls className:(NSString * _Nullable)clsName;
+ (void)printMethodNamesOfClass:(Class)cls;
+ (void)printMethodNamesOfClass:(Class)cls className:(NSString * _Nullable)clsName;

@end

NS_ASSUME_NONNULL_END
