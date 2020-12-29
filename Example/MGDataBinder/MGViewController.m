//
//  MGViewController.m
//  MGDataBinder
//
//  Created by Maling1255 on 12/25/2020.
//  Copyright (c) 2020 Maling1255. All rights reserved.
//

#import "MGViewController.h"

#import "MGSliderViewController.h"
#import "MGTextFieldViewController.h"

#import "MGDataBinderManager.h"




@interface MGViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *displayTableView;
@property (nonatomic, assign) NSInteger count;


@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _count = 10;
    [self.view addSubview:self.displayTableView];
    
    
//    NSString *str1 = @"dfsaskjfnasdkfaskfaskfassdfa";
//
//    NSString *str2 = str1.mutableCopy;
//
//    NSLog(@"%p  %p", str1, str2);
    
}

- (void)injected{
    
    NSLog(@"I've been reinjected: %@", self);
    NSLog(@"这里调用修改页面布局 或者属性设置的代码");
    
    _count = 15;
    [self.displayTableView reloadData];
    
    self.displayTableView.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Slider改变";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"TextField改变";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"其它_%zd", indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MGSliderViewController *SlideVC = [MGSliderViewController loadVCFromStoryboard];
        [self.navigationController pushViewController:SlideVC animated:YES];
    } else if (indexPath.row == 1) {
        MGTextFieldViewController *textFieldVC = [MGTextFieldViewController loadVCFromStoryboard];
        [self.navigationController pushViewController:textFieldVC animated:YES];
    }
}


- (void)viewDidAppear:(BOOL)animated {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{    
        NSLog(@"绑定的内容:::: %@", [[MGDataBinderManager sharedBinderManager] valueForKeyPath:@"binderTargetEntitysHashMap"]);
    });
}

- (UITableView *)displayTableView {
    if (!_displayTableView) {
        _displayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _displayTableView.dataSource = self;
        _displayTableView.delegate = self;
        [_displayTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
    }
    return _displayTableView;
}

@end
