//
//  ViewController.m
//  01-KVO
//
//  Created by MengHao Yin on 2021/3/22.
//

#import "ViewController.h"
#import "MHPerson.h"
#import <objc/runtime.h>
#import "NSObject+Print.h"

@interface ViewController ()
@property (nonatomic, strong) MHPerson *kvo_person;
@property (nonatomic, strong) MHPerson *normal_person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.kvo_person = [[MHPerson alloc] init];
    self.kvo_person.age = 10;
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.kvo_person addObserver:self forKeyPath:@"age" options:options context:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
    self.normal_person = [[MHPerson alloc] init];
    self.normal_person.age = 11;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.kvo_person.age = 20;
    self.normal_person.age = 21;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change = %@", change);
}

//打印出当前对象isa指向
- (void)tapView {
    Class kvo_cls = object_getClass(self.kvo_person);
    Class normal_cls = object_getClass(self.normal_person);
    NSLog(@"kvo_class = %@ normal_class = %@", kvo_cls, normal_cls);
    
    [self printMethodNamesOfClass:kvo_cls className:@"kvo_cls"];
    [self printMethodNamesOfClass: kvo_cls];
    [self printMethodNamesOfClass: normal_cls];
}

@end
