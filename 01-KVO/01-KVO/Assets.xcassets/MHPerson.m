//
//  MHPerson.m
//  01-KVO
//
//  Created by MengHao Yin on 2021/3/22.
//

#import "MHPerson.h"

@implementation MHPerson

//- (void)_isKVOA {
//    NSLog(@"%s", __func__);
//}

//- (BOOL)_isKVOA {
//    NSLog(@"%s", __func__);
//    return YES;
//}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"didChangeValueForKey -- begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey -- end");
}

@end
