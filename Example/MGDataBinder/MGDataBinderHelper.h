//
//  MGDataBinderHelper.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#ifndef MGDataBinderHelper_h
#define MGDataBinderHelper_h

typedef NS_ENUM(NSUInteger, MGPropertyNumberType) {
    MGPropertyNumberTypeChar = 1,
    MGPropertyNumberTypeUChar,
    MGPropertyNumberTypeInt,
    MGPropertyNumberTypeUInt,
    MGPropertyNumberTypeShort,
    MGPropertyNumberTypeUShort,
    MGPropertyNumberTypeFloat,
    MGPropertyNumberTypeDouble,
    MGPropertyNumberTypeBool,
    MGPropertyNumberTypeNSInteger,
    MGPropertyNumberTypeNSUInteger,
};


#define MGTargetProperty id _Nonnull targer, NSString * _Nonnull property
#define MGBlockObj void(^_Nullable block)(id _Nullable obj)
#define MGBlockObjReturnObj id _Nullable(^_Nullable block)(id _Nullable obj)

static NSString * _Nonnull const binder_text = @"text";
static NSString * _Nonnull const binder_value = @"value";
static NSString * _Nonnull const binder_progress = @"progress";

@class MGDataBinder;

typedef MGDataBinder * _Nullable(^MGBinderTarget)(MGTargetProperty);
typedef MGDataBinder * _Nullable(^MGBinderTargetBlock)(MGTargetProperty, MGBlockObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetBlockReturn)(MGTargetProperty, MGBlockObjReturnObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetEvent)(MGTargetProperty, UIControlEvents controlEvent);
typedef MGDataBinder * _Nullable(^MGBinderTargetEventBlockReturn)(MGTargetProperty, UIControlEvents controlEvent, MGBlockObjReturnObj);


#endif /* MGDataBinderHelper_h */
