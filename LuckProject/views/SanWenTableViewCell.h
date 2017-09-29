//
//  SanWenTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiciModel.h"

@interface SanWenTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headView;


@property (weak, nonatomic) IBOutlet UILabel *swTitle;

-(void)headViewAndTitleInCellWith:(ShiciModel*)model;

@end
