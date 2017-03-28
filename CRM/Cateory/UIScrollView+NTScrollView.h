//
//  UIScrollView+NTScrollView.h
//  CRM
//
//  Created by 金波 on 17/2/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    horizon,
    Vertical,
    
} ScrollDirction;

@interface UIScrollView (NTScrollView)

-(void)SetItContentSize:(CGSize)size andSetHorizon:(ScrollDirction)dir andSetpageAble:(BOOL)flase;
@end
