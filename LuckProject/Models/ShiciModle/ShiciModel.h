//
//  ShiciModel.h
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseModel.h"

@interface ShiciModel : BaseModel

@property (nonatomic, assign)NSInteger id;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *thumb;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)NSInteger tracks;

@end
