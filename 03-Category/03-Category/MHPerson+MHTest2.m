//
//  MHPerson+MHTest2.m
//  03-Category
//
//  Created by MengHao Yin on 2021/3/25.
//

#import "MHPerson+MHTest2.h"

@implementation MHPerson (MHTest2)

- (void)eat {
    NSLog(@"MHPerson (Test2) -eat");
}

+ (void)load {
    NSLog(@"MHPerson (Test2) +load");
}

@end
