//
//  PlayerTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/9/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *playTitle;

@property (weak, nonatomic) IBOutlet UILabel *playeTime;
@end
