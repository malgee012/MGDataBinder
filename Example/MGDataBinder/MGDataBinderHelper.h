//
//  MGDataBinderHelper.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#ifndef MGDataBinderHelper_h
#define MGDataBinderHelper_h

typedef NS_ENUM(NSUInteger, MGBlockType) {
    MGBlockTypeNone,
    /** 无参无返回值 */
    MGBlockTypeVoidVoid,
    /** 无参有返回值 */
    MGBlockTypeVoidObj,
    /** 有参无返回值 */
    MGBlockTypeObjVoid,
    /** 有参有返回值 */
    MGBlockTypeObjObj,
};

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
#define MGBlock void(^_Nullable block1)(void)
#define MGBlockObj void(^_Nullable block2)(id _Nullable obj)
#define MGBlockReturnObj id _Nullable(^_Nullable block3)(void)
#define MGBlockObjReturnObj id _Nullable(^_Nullable block4)(id _Nullable obj)

static NSString * _Nonnull const binder_text = @"text";
static NSString * _Nonnull const binder_value = @"value";
static NSString * _Nonnull const binder_progress = @"progress";

@class MGDataBinder;

typedef MGDataBinder * _Nullable(^MGBinderTarget)(MGTargetProperty);
typedef MGDataBinder * _Nullable(^MGBinderTargetBlock)(MGTargetProperty, MGBlock);
typedef MGDataBinder * _Nullable(^MGBinderTargetBlockObj)(MGTargetProperty, MGBlockObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetBlockReturnObj)(MGTargetProperty, MGBlockReturnObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetBlockObjReturnObj)(MGTargetProperty, MGBlockObjReturnObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetEvent)(MGTargetProperty, UIControlEvents controlEvent);
typedef MGDataBinder * _Nullable(^MGBinderTargetEventBlock)(MGTargetProperty, UIControlEvents controlEvent, MGBlock);
typedef MGDataBinder * _Nullable(^MGBinderTargetEventBlockObj)(MGTargetProperty, UIControlEvents controlEvent, MGBlockObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetEventBlockReturnObj)(MGTargetProperty, UIControlEvents controlEvent, MGBlockReturnObj);
typedef MGDataBinder * _Nullable(^MGBinderTargetEventBlockObjReturnObj)(MGTargetProperty, UIControlEvents controlEvent, MGBlockObjReturnObj);


#endif /* MGDataBinderHelper_h */
