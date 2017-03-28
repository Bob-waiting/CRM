//
//  NTNetworking.m
//  CRM
//
//  Created by 金波 on 16/5/4.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "NTNetworking.h"
#import <AFNetworking.h>
@implementation NTNetworking

#pragma mark--异步请求数据--
-(NSDictionary *)requestData:(NSString *)address anddic:(NSDictionary *)dic
{
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    
    mgr.requestSerializer.timeoutInterval=60;  //设置请求超时时限
    
    
    __block NSDictionary *returnDic=@{}; //返回值
    
    [mgr GET:address parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"-------%lld*******%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            returnDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            returnDic=nil;
            UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"警告" message:@"网络请求错误" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC presentViewController:alertVC animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,2.0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alertVC dismissViewControllerAnimated:YES completion:nil];
                    
                });
                
            }];
        }
        
    }];
    
    return returnDic;
}



@end
