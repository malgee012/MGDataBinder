//
//  MGTextFieldViewController.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/29.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGTextFieldViewController.h"

@interface MGTextFieldViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@end

@implementation MGTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)injected {
    self.textField1.backgroundColor = [UIColor redColor];
    
    
    self.textLbl.text = [NSString stringWithFormat:@"文本：飞机飞机飞机"];
    self.view.backgroundColor = [UIColor orangeColor];
}

@end
