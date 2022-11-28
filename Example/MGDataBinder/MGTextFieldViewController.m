//
//  MGTextFieldViewController.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/29.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGTextFieldViewController.h"
#import "MGDataBinder.h"
@interface MGTextFieldViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@end

@implementation MGTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MGDataBinder binder]
    .bindBlockObjRObjSet(self.textLbl, binder_text, ^NSString *(NSString *text) {
        return [NSString stringWithFormat:@"重新编译的文本%@~~~", text];
    })
    .bindEventBlockObjRObjSet(self.textField1, binder_text, UIControlEventEditingChanged, ^NSString *(NSString *text) {
        if (text.length >= 20) {
            text = [text substringToIndex:18];
        }
        return text;
    })
    .bindEventBlockObjRObjSet(self.textField2, binder_text, UIControlEventEditingChanged, ^NSString *(NSString *text) {
        return [NSString stringWithFormat:@"_%@_",text];
    })
    ;
}


- (IBAction)clickbutton1:(id)sender {
 
    self.textLbl.text = @"12306";
    
    [self.view endEditing:YES];
}

- (IBAction)clickbutton2:(id)sender {
    [self.view endEditing:YES];
}

- (void)injected {
    self.textField1.backgroundColor = [UIColor redColor];
    
    
    self.textLbl.text = [NSString stringWithFormat:@"文本：飞机飞机飞机"];
    self.view.backgroundColor = [UIColor orangeColor];
}

@end
