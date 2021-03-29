//
//  ViewController.m
//  02-Runtime Cache_t
//
//  Created by MengHao Yin on 2021/3/24.
//

#import "ViewController.h"
#import "MHPerson.h"
#import <objc/runtime.h>
typedef uint32_t mask_t;  // x86_64 & arm64 asm are less efficient with 16-bits

struct lg_bucket_t {
    SEL _sel;
    IMP _imp;
};

struct lg_cache_t {
    struct lg_bucket_t * _buckets;
    mask_t _mask;
    uint16_t _flags;
    uint16_t _occupied;
};

struct lg_class_data_bits_t {
    uintptr_t bits;
};

struct lg_objc_class {
    Class ISA;
    Class superclass;
    struct lg_cache_t cache;             // formerly cache pointer and vtable
    struct lg_class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
};
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MHPerson *person = [[MHPerson alloc] init];
    Class pClass = [MHPerson class];

    [person hello1];
    [person hello2];
    [person hello3];
    [person hello4];
    
    struct lg_objc_class *lg_pClass = (__bridge struct lg_objc_class *)(pClass);
    NSLog(@"%hu - %u",lg_pClass->cache._occupied,lg_pClass->cache._mask);
    
    for (mask_t i = 0; i<lg_pClass->cache._mask; i++) {
        // 打印获取的 bucket
        struct lg_bucket_t bucket = lg_pClass->cache._buckets[i];
        NSLog(@"%@ - %p",NSStringFromSelector(bucket._sel),bucket._imp);
    }
}


@end
