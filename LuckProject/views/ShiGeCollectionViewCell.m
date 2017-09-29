//
//  ShiGeCollectionViewCell.m
//  LuckProject
//
//  Created by moxi on 2017/9/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ShiGeCollectionViewCell.h"

@implementation ShiGeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)itemHeadViewAndTitleInCellBy:(ShiciModel *)model{
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:ECIMAGENAME(@"zhanwei")];
    self.shigeTitle.text = model.title;
}

@end
