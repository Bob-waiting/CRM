//
//  NTCustomViewController.m
//  CRM
//
//  Created by 金波 on 16/4/16.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "NTCustomViewController.h"

@interface NTCustomViewController ()
{
    NSMutableArray *origDataArray;
}
@property (nonatomic,strong)UISearchController *searchController;
@property(nonatomic, strong)IBOutlet UITableView *CustomTable;
@property(nonatomic,copy)NSMutableArray *dataArray;
@end

@implementation NTCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    origDataArray=[NSMutableArray array];
    for (long int i=0; i<20;i++) {
        [origDataArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    _dataArray=origDataArray;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self setSubView];
}
#pragma mark--设置界面的样式--
-(void)setSubView
{
    //设置tabbaritem的样式
    
    self.navigationController.tabBarItem.title=@"客户";
    [self.navigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"图层-4"]];
    [ self.navigationController.tabBarItem setImage:[UIImage imageNamed:@"view-details-100"]];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //对navigationitem进行设置
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1];
    self.navigationItem.title=@"客户";
    
    //对searchController进行设置
    
    _searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchBar.placeholder=@"搜索";
    _searchController.searchBar.showsCancelButton=NO;
    _searchController.dimsBackgroundDuringPresentation=YES;
    _searchController.delegate=self;
    _searchController.searchBar.delegate=self;
    _searchController.hidesNavigationBarDuringPresentation=NO;
    _searchController.searchResultsUpdater=self;
    _CustomTable.tableHeaderView=_searchController.searchBar;
    
    //对CustomTable进行设置
    
    _CustomTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_CustomTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomIdentCell"];
    
}

#pragma mark--CustomTable代理方法--
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"CustomIdentCell";
  UITableViewCell *cell=[_CustomTable dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text=[_dataArray objectAtIndex: indexPath.row];
    return cell;
    
}

#pragma mark--searchController的searchResultsUpdater代理方法--
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (searchController.searchBar.text.length==0) {
        _dataArray=origDataArray;
    }
    else
    {
 NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchController.searchBar.text];
  _dataArray= (NSMutableArray *) [origDataArray filteredArrayUsingPredicate:filterPredicate];
    }
    [_CustomTable reloadData];
                                 
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
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
