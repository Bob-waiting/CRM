//
//  NTSettingViewController.m
//  CRM
//
//  Created by 金波 on 16/4/16.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "NTSettingViewController.h"

@interface NTSettingViewController ()
{
    NSArray *setArray;//设置选项；
}
@end

@implementation NTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     setArray=@[@"修改密码",@"生日提醒"];
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
    
    self.navigationController.tabBarItem.title=@"设置";
    [self.navigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"settings-filled-100"]];
    [ self.navigationController.tabBarItem setImage:[UIImage imageNamed:@"settings-100"]];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //对navigationitem进行设置
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1];
    self.navigationItem.title=@"设置";
}

#pragma mark--tableview的代理方法--
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return setArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString static *ident=@"setIdent";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.text=[setArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
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
