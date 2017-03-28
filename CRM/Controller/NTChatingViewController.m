//
//  NTChatingViewController.m
//  CRM
//
//  Created by 金波 on 16/4/16.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "NTChatingViewController.h"

@interface NTChatingViewController ()

@end

@implementation NTChatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --设置界面的样式－－
-(void)setSubView
{
    //设置tabbaritem的样式
    
    self.navigationController.tabBarItem.title=@"聊天";
    [self.navigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"矩形-1"]];
    [ self.navigationController.tabBarItem setImage:[UIImage imageNamed:@"high-volume-100"]];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //对navigationitem进行设置
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1];
    self.navigationItem.title=@"聊天";
    
 
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
