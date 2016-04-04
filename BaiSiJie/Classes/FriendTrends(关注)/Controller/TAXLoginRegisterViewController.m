//
//  TAXLoginRegisterViewController.m
//  BaiSiJie
//
//  Created by 谭安溪 on 16/3/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

#import "TAXLoginRegisterViewController.h"

@interface TAXLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginConstraint;

@end

@implementation TAXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
 
}

- (void)setTextFieldPlaceHolderAttr{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
    [placeholder setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(1, 1)];
    [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} range:NSMakeRange(2, 1)];
    self.phoneTextField.attributedPlaceholder = placeholder;
}

- (IBAction)loginClose {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerBtClick:(UIButton *)bt {
    [self.view endEditing:YES];
    if (self.loginConstraint.constant == 0) {
        self.loginConstraint.constant = -self.view.size.width;
//        [bt setTitle:@"已有账号?" forState:UIControlStateNormal];
        bt.selected = YES;
    }else{
        self.loginConstraint.constant = 0;
//         [bt setTitle:@"注册账号" forState:UIControlStateNormal];
        bt.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
