//
//  ResultViewController.m
//  TransitionDemo
//
//  Created by watchnail on 2017/4/25.
//  Copyright © 2017年 watchnail. All rights reserved.
//

#import "ResultViewController.h"
@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ResultViewController";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode =  UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"girl.jpg"];
    [self.view addSubview:imageView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
