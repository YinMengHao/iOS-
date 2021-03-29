//
//  main.m
//  04-Block
//
//  Created by MengHao Yin on 2021/3/29.
//

#import <Foundation/Foundation.h>
#import "MHPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        
        
        
        int e = 3;
        NSLog(@"%@", ^{ printf("===="); });
        NSLog(@"%@", [^{ printf("===="); } copy]);

        NSLog(@"%@", ^{ printf("%d\n", e); });
        NSLog(@"%@", [^{ printf("%d\n", e); } copy]);

        NSLog(@"%@", [^{ printf("%d\n", e); } class]);
//        int a = 10;
        MHPerson *person = [[MHPerson alloc] init];
        NSLog(@"person = %@", person);
        person.age = 10;
        void (^block)(void) = ^{
            NSLog(@"person.age = %d person = %@", person.age, person);
        };
        person.age = 20;
        person = nil;
        block();
    }
    return 0;
}
