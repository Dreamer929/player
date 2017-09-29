//
//  BaseModel.h
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

-(instancetype)valueForKey:(NSString *)key;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
