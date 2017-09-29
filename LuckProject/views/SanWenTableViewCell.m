//
//  SanWenTableViewCell.m
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "SanWenTableViewCell.h"

@implementation SanWenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)headViewAndTitleInCellWith:(ShiciModel *)model{
        
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [self.headView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:ECIMAGENAME(@"zhanwei")];
        self.swTitle.text = model.title;
//    });
    
}

@end
