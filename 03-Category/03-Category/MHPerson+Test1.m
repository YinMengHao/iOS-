//
//  MHPerson+Test1.m
//  03-Category
//
//  Created by MengHao Yin on 2021/3/25.
//

#import "MHPerson+Test1.h"

@implementation MHPerson (Test1)

- (void)eat {
    NSLog(@"MHPerson (Test1) -eat");
}

+ (void)load {
    NSLog(@"MHPerson (Test1) +load");
}

@end
