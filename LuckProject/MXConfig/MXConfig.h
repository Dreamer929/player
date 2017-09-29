//
//  MXConfig.h
//  LuckProject
//
//  Created by moxi on 2017/9/28.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const CHANGESTYLE_KEY;
extern NSString *const HISTORY_KEY;

@interface MXConfig : NSObject

@property (nonatomic, copy)NSString *styleStr;
@property (nonatomic, copy)NSString *history;

+(instancetype)shareInstance;
-(void)saveStyleStr:(NSString *)string;
-(void)saveHistory:(NSString *)string;

@end
