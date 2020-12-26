//
//  MGBaseModel.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGBaseModel : NSObject

@property (nonatomic, copy) void(^myBlock)(NSString *str);
@property (nonatomic, copy) NSString *identification;


@property (nonatomic, assign) int int_age;
@property (nonatomic, assign) unsigned int unsigned_int_age;
@property (nonatomic, assign) short short_age;
@property (nonatomic, assign) unsigned short unsigned_short_age;
@property (nonatomic, assign) long long_age;
//@property (nonatomic, assign) unsigned long unsigined_long_age;
@property (nonatomic, assign) long long long_long_age;
@property (nonatomic, assign) unsigned long long unsigned_long_long_age;
@property (nonatomic, assign) float float_age;
@property (nonatomic, assign) double double_age;
@property (nonatomic, assign) bool BOOL_age1;
@property (nonatomic, assign) BOOL BOOL_age;
@property (nonatomic, assign) NSInteger integer_age;
@property (nonatomic, assign) NSUInteger uinteger_age;


@property (nonatomic, assign) SEL  selecter;
@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) NSMutableDictionary *mutableInfo;

@end

NS_ASSUME_NONNULL_END
