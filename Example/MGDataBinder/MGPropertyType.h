//
//  MGPropertyType.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/26.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGDataBinderHelper.h"
NS_ASSUME_NONNULL_BEGIN

@interface MGPropertyType : NSObject

/** 类型标识符 */
@property (nonatomic, copy) NSString *code;

/** 是否为id类型, 即 NSString， NSNumber， NSArray， NSDictionary， NSSet，自定义对象等 */
@property (nonatomic, readonly, getter=isIdType) BOOL idType;

/** 是否为基本数字类型：int、float  bool等 */
@property (nonatomic, readonly, getter=isNumberType) BOOL numberType;
/** 基本数字类型 对应的 number  类型 */
@property (nonatomic, assign, readonly) MGPropertyNumberType propertyNumberType;
/** 是否为BOOL类型 */
@property (nonatomic, readonly, getter=isBoolType) BOOL boolType;
/** 对象类型（如果是基本数据类型，此值为nil） */
@property (nonatomic, readonly) Class typeClass;

/** 类型是否来自于Foundation框架，比如NSString、NSNumber、 NSArray， NSDictionary， NSSet */
@property (nonatomic, readonly, getter = isFromFoundation) BOOL fromFoundation;
/** 类型是否不支持KVC */
@property (nonatomic, readonly, getter = isKVCDisabled) BOOL KVCDisabled;

+ (id)getPropertyTypeWithTarget:(__kindof NSObject *)target property:(NSString *)propertyName;

@end

NS_ASSUME_NONNULL_END
