//
//  MGTargetModel.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGPropertyType.h"
NS_ASSUME_NONNULL_BEGIN

@interface MGTargetModel : NSObject

@property (nonatomic, copy, readonly) NSString *bindId;
@property (nonatomic, copy, readonly) NSString *signId;
@property (nonatomic, strong) id target;
@property (nonatomic, copy) NSString *property;
@property (nonatomic, strong) MGPropertyType *propertyType;
@property (nonatomic, assign) UIControlEvents controlEvent;
@property (nonatomic, copy) void(^ _Nullable actionBlock)(id _Nullable obj);
@property (nonatomic, copy) id _Nullable (^ _Nullable actionReturnBlock)(id _Nullable obj);

- (BOOL)didChangeValue;

- (void)setValue:(id)value;

@end

NS_ASSUME_NONNULL_END
