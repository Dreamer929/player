//
//  MXAPI.h
//  LuckProject
//
//  Created by moxi on 2017/9/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShiciModel.h"


@interface MXAPI : NSObject

+(void)getShiCiListByKeyword:(NSString*)keyword page:(NSInteger)page dataBlock:(void(^)(NSMutableArray* data,NSString *error))block;

+(void)getShiCiDetialListByModel:(ShiciModel*)model page:(NSInteger)page callBlack:(void(^)(NSMutableArray *data,NSString *error))block;

+(void)getBangDanBy:(NSInteger)bd_id page:(NSInteger)page dataBlock:(void(^)(NSMutableArray *data,NSString *error))block;

+ (void)getSearchMainListDataBlock:(void(^)(NSMutableArray *data,NSString *error))block;

+ (void)getSearchResultListBykeyword:(NSString *)keyword isTrack:(BOOL)istrack page:(NSInteger)page callblock:(void(^)(NSMutableArray *data,NSString *error))block;


@end
