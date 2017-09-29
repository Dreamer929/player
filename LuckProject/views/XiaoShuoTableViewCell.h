//
//  XiaoShuoTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiaoShuoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headview;
@property (weak, nonatomic) IBOutlet UILabel *xsTitle;
@property (weak, nonatomic) IBOutlet UILabel *xsIntro;

-(void)headViewAndTitleInCellWith:(ShiciModel*)model;


@end
