//
//  NTCollectionViewCell.m
//  CRM
//
//  Created by 金波 on 2017/3/8.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "NTCollectionViewCell.h"

@implementation NTCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    }
-(void)setCornerRedius:(CGFloat)cornerRedius
{
    _img.layer.masksToBounds=YES;
    _img.layer.cornerRadius=cornerRedius;
}
@end
