//
//  DingzhiCollectionViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/9/28.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DingzhiCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dzTitle;
@property (nonatomic, assign)BOOL isSelected;

@end
