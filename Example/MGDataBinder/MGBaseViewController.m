//
//  MGBaseViewController.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGBaseViewController.h"

@interface MGBaseViewController ()

@end

@implementation MGBaseViewController

+ (id)loadVCFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    
//    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]firstObject];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)dealloc {
    NSLog(@"\n\n 🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀\n\n dealloc:: %@ \n\n -------------------------------------------------------------------------------------------------------- \n\n", NSStringFromClass(self.class));
}

@end
