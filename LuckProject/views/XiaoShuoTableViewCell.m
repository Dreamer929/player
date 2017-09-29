//
//  XiaoShuoTableViewCell.m
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "XiaoShuoTableViewCell.h"

@implementation XiaoShuoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)headViewAndTitleInCellWith:(ShiciModel*)model{
    
    [self.headview sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:ECIMAGENAME(@"zhanwei")];
    self.xsTitle.text = model.title;
    self.xsIntro.text = model.intro;
}

@end
