//
//  NTMenuViewController.m
//  CRM
//
//  Created by 金波 on 16/4/16.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "NTMenuViewController.h"
#import "UIScrollView+NTScrollView.h"
#import "NTCollectionViewCell.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define Height(args) (args*([UIScreen mainScreen].bounds.size.height)/667)
#define ScrollContent_Count 4

typedef NS_ENUM(NSUInteger,tag)
{
    scrollViewtag=200
    
    
};

@interface NTMenuViewController ()
{
    NSTimer *timer;//scrollView定时滚动计时器
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation NTMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //判断用户是否退出登录或者第一次登陆
    BOOL isFirstLogin=[[NSUserDefaults standardUserDefaults]boolForKey:isNotFirstLogin];
    
    if (!isFirstLogin) {
     UIViewController *loginVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
        loginVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
//    _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _hud.label.text=@"错误";
//    
////    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
////    redView.backgroundColor=[UIColor redColor];
//   // _hud.customView=redView;
//    [self.view addSubview:_hud];
//    [_hud hideAnimated:YES afterDelay:3.0];
    
    
}
#pragma mark --对界面进行设置
-(void)setSubView{
    
    //对tabbaritem进行设置
    
    self.navigationController.tabBarItem.title=@"主页";
    [self.navigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"home_check"]];
    [ self.navigationController.tabBarItem setImage:[UIImage imageNamed:@"形状-1"]];
    self.navigationController.tabBarItem.imageInsets=UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, CGFLOAT_MAX)];
    [ self.navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //navigationitem进行设置
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1];
    self.navigationItem.title=@"主页";
    
    //对滚动条进行设置
    
    [self setScrollView];
    
}

-(void)setScrollView
{
    //添加滚动条
    
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height(150))];
    }
    [_scrollView SetItContentSize:CGSizeMake((ScrollContent_Count)*ScreenWidth, Height(150)) andSetHorizon:horizon
                   andSetpageAble:YES];
    _scrollView.bounces=NO;
    _scrollView.tag=scrollViewtag;
    _scrollView.directionalLockEnabled=YES;
   // _scrollView.delegate=self;
    _scrollView.contentOffset=CGPointMake(0, 0);
    for (int i=1; i<ScrollContent_Count+1; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((i-1)*ScreenWidth, 0, ScreenWidth, Height(150))];
        img.contentMode=UIViewContentModeScaleAspectFill;
        img.image=[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i]];
        [_scrollView addSubview:img];
    }
    //添加滚动控制器
    
    _pageControl=[[UIPageControl alloc]init];
    _pageControl.frame=CGRectMake(0, 0, 100, 20);
    _pageControl.center=CGPointMake(self.view.center.x,130);
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=ScrollContent_Count;
    _pageControl.pageIndicatorTintColor=[UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:37/255.0 green:146/255.0 blue:213/255.0 alpha:1];
    
    //添加scrollView滚动计时器
    
    timer=[NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
     long int  count=_pageControl.currentPage;
          count++;
    [UIView animateWithDuration:1.0 delay:0.1 options:0 animations:^{
        _scrollView.contentOffset=CGPointMake((count%ScrollContent_Count)*KscreenWidth, 0);
        _pageControl.currentPage=(count)%ScrollContent_Count;
    } completion:nil];
    
    }];
    
    //添加collectionView
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=0.1;
    layout.minimumInteritemSpacing=0.1;
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight-44) collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView2"];

    [_collectionView registerNib:[UINib nibWithNibName:@"NTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.view addSubview:_collectionView];
}


#pragma mark--scrollView代理方法--
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView.tag==scrollViewtag) {
        
         [timer setFireDate:[NSDate distantFuture]];
    }
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag==scrollViewtag) {

    _pageControl.currentPage=(scrollView.contentOffset.x/KscreenWidth);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [timer setFireDate:[NSDate distantPast]];
    });
    }
}

#pragma mark--collectionView代理方法--
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   
    if (kind==UICollectionElementKindSectionHeader) {
        
        if (indexPath.section==0) {
             UICollectionReusableView *view1=[collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath ];
            [view1 addSubview:_scrollView];
            [view1 addSubview:_pageControl];
            return view1;
        
        }else
        {
            UICollectionReusableView *view1=[collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView2" forIndexPath:indexPath ];
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 44)];
            lable.text=[NSString stringWithFormat:@"第%ld组",indexPath.section];
            [view1 addSubview:lable];
            return view1;
        }
    }else
    {
        return nil;
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 8;
    }
    return 4;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"collectionCell";
    NTCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.img.image=[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld",(indexPath.row)%4+1]];
    if (indexPath.section==0) {
        cell.cornerRedius=(cell.frame.size.width-30)/2;
    }else
    {
        cell.cornerRedius=2.0;
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KscreenWidth-8)/4,(KscreenWidth-8)/4);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(KscreenWidth, Height(150));
    }
    return CGSizeMake(KscreenWidth, 44);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *loginVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
    loginVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginVC animated:YES completion:nil];

}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    if (section==0) {
        return 0;
    }else
    {
        return 15;
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
