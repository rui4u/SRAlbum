//
//  SRAlertController.m
//  alertTest
//
//  Created by sharui on 2016/12/26.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRAlertController.h"

@interface SRAlertController ()

/**
 自定义图层
 */
@property (nonatomic ,strong ) UIButton * hideButton;
@end

@implementation SRAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
   
    if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        
        self.hideButton =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.view.frame.size.height)];
        
        [self.hideButton addTarget:self action:@selector(viewHideTap) forControlEvents:UIControlEventTouchUpInside];
        UIWindow * window =  [[UIApplication sharedApplication].delegate window];
        [window addSubview:self.hideButton];
    }

}

- (void)viewHideTap {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.hideButton removeFromSuperview];
    self.hideButton = nil;

}
- (void)dealloc {


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
