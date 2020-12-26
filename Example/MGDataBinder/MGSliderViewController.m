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

@interface MGSliderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *leftLbl;
@property (weak, nonatomic) IBOutlet UILabel *rightLbl;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (nonatomic, strong) MGBaseModel *model;


@end

@implementation MGSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [MGBaseModel new];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.leftLbl.text = @"123";
    self.rightLbl.text = @"321";
    
    self.slider.value = 0;
    self.slider.maximumValue = 100;
    
    
    MGDataBinder *binder = [MGDataBinder new];
    NSLog(@":: %@", binder.bindId);
    
    binder
    .binderTargetSet(self.model, @"identification")
    
//    .binderTargetSet(self.model, @"myBlock")
//    .binderTargetSet(self.model, @"delegate")
//    .binderTargetSet(self.model, @"isChange")
//    .binderTargetSet(self.model, @"selecter")
    
//    .binderTargetSet(self.model, @"int_age")
//    .binderTargetSet(self.model, @"unsigned_int_age")
//    .binderTargetSet(self.model, @"short_age")
//    .binderTargetSet(self.model, @"unsigned_short_age")
//    .binderTargetSet(self.model, @"long_age")
//    .binderTargetSet(self.model, @"long_long_age")
//    .binderTargetSet(self.model, @"unsigned_long_long_age")
//    .binderTargetSet(self.model, @"float_age")
//    .binderTargetSet(self.model, @"double_age")
//    .binderTargetSet(self.model, @"BOOL_age1")
//    .binderTargetSet(self.model, @"BOOL_age")
//    .binderTargetSet(self.model, @"integer_age")
//    .binderTargetSet(self.model, @"uinteger_age")
//    .binderTargetSet(self.model, @"array")
    
    
//    .binderTargetSet(self.model, @"array")
//    .binderTargetSet(self.model, @"mutableArray")
//    .binderTargetSet(self.model, @"info")
//    .binderTargetSet(self.model, @"mutableInfo")
    .binderTargetSet(self.leftLbl, binder_text)
    .binderTargetBlockSet(self.slider, binder_value, ^{
        NSLog(@"更新了block");
    })
    .binderTargetBlockObjReturnObjSet(self.progressView, binder_progress, ^NSNumber *(NSNumber *value) {
        float tempValue = [value floatValue];
        tempValue = tempValue / 100.f;
        return @(tempValue);
    })
    ;
    
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

@end
