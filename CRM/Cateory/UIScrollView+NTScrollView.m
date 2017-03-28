//
//  UIScrollView+NTScrollView.m
//  CRM
//
//  Created by 金波 on 17/2/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "UIScrollView+NTScrollView.h"


@implementation UIScrollView (NTScrollView)

-(void)SetItContentSize:(CGSize)size  andSetHorizon:(ScrollDirction)dir andSetpageAble:(BOOL)flase;
{
    self.contentSize=size;
    
    if (dir==horizon) {
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
    }
    if (dir==Vertical) {
        self.showsVerticalScrollIndicator=NO;
        self.showsHorizontalScrollIndicator=NO;
    }
    
    self.pagingEnabled=flase;
    
}




@end
