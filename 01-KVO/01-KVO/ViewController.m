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
#import "Test.h"

@interface ViewController ()
@property (nonatomic, strong) MHPerson *kvo_person;
@property (nonatomic, strong) MHPerson *normal_person;
@end

@implementation ViewController

/**
 KVO:  (Key - Value - Observer) 键值观察者
 原理：
 1.利用Runtime 生成一个全新的子类(NSKVONotifying_<ClassName>)，并将instance实例的isa指向这个子类（此子类的superClass为原来的类）
 2.重写set<keyPath>： clss， dealloc，_isKVOA
 3.当修改instanch对象的属性时，会调用Foundation的_NSSetXXXValueAndNotify函数
    willChangeValueForKey:
    父类原来的setter方法
    didChangeValueForKey: (方法内部会触发监听器（Oberser）的监听方法（observeValueForKeyPath: ofObject: change: context:）)
 
 如果属性的变化在子线程 observeValueForKeyPath: ofObject: change: context:的调用 也将在子线程
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.kvo_person = [[MHPerson alloc] init];
    self.kvo_person.age = 10;
    self.kvo_person.array = @[@1, @2];
//    [self printMethodNamesOfClass:[NSObject class]];
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial;
    [self.kvo_person addObserver:self forKeyPath:@"age" options:options context:nil];
    [self.kvo_person addObserver:self forKeyPath:@"array" options:options context:nil];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
//    tap.numberOfTapsRequired = 2;
//    [self.view addGestureRecognizer:tap];
//
//    self.normal_person = [[MHPerson alloc] init];
//    self.normal_person.age = 11;
    
    [self test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.kvo_person.age = 20;
//    self.normal_person.age = 21;
    dispatch_queue_t queue = dispatch_queue_create("aaaa", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"current thread = %@", [NSThread currentThread]);
//        [self.kvo_person setValue:@20 forKey:@"age"];
        self.kvo_person.age = 20;
        self.kvo_person.array = @[@3];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"observeValueForKeyPath current thread = %@", [NSThread currentThread]);
    NSLog(@"change = %@", change);
//    [self.kvo_person removeObserver:self forKeyPath:@"age"];
//        [self.kvo_person removeObserver:self forKeyPath:@"array"];
}

- (void)test {
    Test *test = [[Test alloc] init];
    ///_isKVOA是NSObject的方法
    if ([test respondsToSelector:@selector(_isKVOA)]) {
        NSLog(@"test respondsToSelector _isKVOA");
        [test performSelector:@selector(_isKVOA)];
    }
    [self printMethodNamesOfClass:object_getClass(test) className:@"Test"];
}

//打印出当前对象isa指向
- (void)tapView {
    Class kvo_cls = object_getClass(self.kvo_person);
    Class normal_cls = object_getClass(self.normal_person);
    NSLog(@"kvo_class = %@ normal_class = %@", kvo_cls, normal_cls);
    
//    [self printMethodNamesOfClass:kvo_cls className:@"kvo_cls"];
    [self printMethodNamesOfClass:normal_cls className:@"normal_cls"];
}

@end
