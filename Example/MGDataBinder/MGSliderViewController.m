//
//  MGSliderViewController.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGSliderViewController.h"
#import "MGDataBinder.h"
#import "MGBaseModel.h"

#import "MGDataBinderManager.h"
@interface MGSliderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *leftLbl;
@property (weak, nonatomic) IBOutlet UILabel *rightLbl;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (nonatomic, strong) MGBaseModel *model;


@end

@implementation MGSliderViewController

- (void)clickButton1 {
    NSLog(@"响应了事件1");
}

- (void)clickButton2 {
    NSLog(@"响应了事件2");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [MGBaseModel new];
    self.model.person = [MGPerson new];
    self.model.person.student = [MGStudent new];
    
    self.leftLbl.text = @"123";
    self.rightLbl.text = @"321";
    
    self.slider.value = 0;
    self.slider.maximumValue = 100;
    
    [self.testButton addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    
    [MGDataBinder setEnableLog:YES];
    
    __weak typeof(self)weakSelf = self;
    
    
//    MGDataBinder *binder = [MGDataBinder new];
//    NSLog(@"创建bindid:: %@", binder.bindId);
    Binder()
    .bindSet(self.model, @"identification")
//    .bindBlockObjSet(self.model, @"person.age", ^(id obj){
//        NSLog(@"age: %@", obj);
//    })
//    .bindBlockObjSet(self.model, @"person.student.age", ^(id obj){
//        NSLog(@"age_____: %@  %@", obj, weakSelf.model.person.student.age);
//    })
    
//    .bindSet(self.model, @"myBlock")
//    .bindSet(self.model, @"delegate")
//    .bindSet(self.model, @"isChange")
//    .bindSet(self.model, @"selecter")
//    .bindBlockObjSet(self.model, @"int_age", ^(id obj){
//        NSLog(@"age: %@", obj);
//    })
//    .bindSet(self.model, @"unsigned_int_age")
//    .bindSet(self.model, @"short_age")
//    .bindSet(self.model, @"unsigned_short_age")
//    .bindSet(self.model, @"long_age")
//    .bindSet(self.model, @"long_long_age")
//    .bindSet(self.model, @"unsigned_long_long_age")
//    .bindSet(self.model, @"float_age")
//    .bindSet(self.model, @"double_age")
//    .bindSet(self.model, @"BOOL_age1")
//    .bindSet(self.model, @"BOOL_age")
//    .bindSet(self.model, @"integer_age")
//    .bindSet(self.model, @"uinteger_age")
//    .bindSet(self.model, @"array")
//    .bindSet(self.model, @"array")
//    .bindSet(self.model, @"mutableArray")
//    .bindSet(self.model, @"info")
//    .bindSet(self.model, @"mutableInfo")
//    .bindSet(self.leftLbl, binder_text)
//    .bindSet(self.rightLbl, binder_text)
    .bindEventBlockObjSet(self.slider, binder_value, UIControlEventValueChanged, ^(id obj) {
        if ([obj isKindOfClass:[weakSelf.slider class]]) {
            NSLog(@"UI主动更新回调");
        } else {
//            NSLog(@"同步更新回调------ %@", obj);
        }
    })
    .bindBlockObjRObjSet(self.progressView, binder_progress, ^NSNumber *(NSNumber *value) {
        float tempValue = [value floatValue];
        tempValue = tempValue / 100.f;
        return @(tempValue);
    })
    ;
    
    
    // MARK: 绑定 UISlider 和 self.progressView
//    MGDataBinder *binder2 =  [MGDataBinder binder];
//    Binder()
//    .bindSet(self.slider, binder_value)
//    .bindBlockObjReturnObjSet(self.progressView, binder_progress, ^NSNumber *(NSNumber *value) {
//        float tempValue = [value floatValue];
//        tempValue = tempValue / 100.f;
//        return @(tempValue);
//    });
    
}

static int _count;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    self.model.identification = [NSString stringWithFormat:@"%d", _count++];
}

int current = 0;
- (IBAction)tapStepper:(UIStepper *)stepper {
    int value = (int)stepper.value;
    if (value > current) {
        self.model.identification = [NSString stringWithFormat:@"%d", value];
    } else {
        self.model.identification = [NSString stringWithFormat:@"%d", ({
            int temp = value;
            if (value <= 0) {
                temp = 50;
            }
            temp;
        })];
    }
    current = value;
}

- (void)dealloc {
    
    for (int i = 0; i < self.view.subviews.count; i++) {
        NSLog(@"🐱>> %@", self.view.subviews[i]);
    }
    
    
    NSLog(@"🐱🐱🐱  dealloc: %s", __func__);
}

@end
