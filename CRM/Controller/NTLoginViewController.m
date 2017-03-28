//
//  NTLoginViewController.m
//  CRM
//
//  Created by 金波 on 16/4/17.
//  Copyright © 2016年 Bob. All rights reserved.
//

/**
 
 @description:登录界面
 
 */
#import "NTLoginViewController.h"

@interface NTLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;

@end

@implementation NTLoginViewController

#pragma mark --登录按钮的点击事件
- (IBAction)doLoginAction:(id)sender {
    
    
    
    if ([_accountTextView.text isEqualToString:@"jin"]&&[_passwordTextView.text isEqualToString:@"123"]) {
    
    [self dismissViewControllerAnimated:YES completion:nil];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:isNotFirstLogin];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
