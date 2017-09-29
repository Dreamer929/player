//
//  MXConfig.m
//  LuckProject
//
//  Created by moxi on 2017/9/28.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MXConfig.h"

NSString *const CHANGESTYLE_KEY = @"ischange_key";
NSString *const HISTORY_KEY = @"history_key";

@implementation MXConfig

+(instancetype)shareInstance{
    
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MXConfig alloc]init];
    });
    
    [shareInstance loadUserInfo];
    return shareInstance;
}


-(void)loadUserInfo{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:CHANGESTYLE_KEY]!=nil) {
        self.styleStr = [defaults objectForKey:CHANGESTYLE_KEY];
    }else{
        self.styleStr = nil;
    }
    if ([defaults objectForKey:HISTORY_KEY]!= nil) {
        self.history = [defaults objectForKey:HISTORY_KEY];
    }else{
        self.history = nil;
    }
}

-(void)saveInfo{
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    [defauls setObject:self.styleStr forKey:CHANGESTYLE_KEY];
    [defauls setObject:self.history forKey:HISTORY_KEY];
    
    [defauls synchronize];
}

-(void)saveStyleStr:(NSString *)string{
    
    self.styleStr = string;
    [self saveInfo];
}

-(void)saveHistory:(NSString *)string{
    
    self.history = string;
    [self saveInfo];
}

@end
