//
//  MGPropertyType.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/26.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGPropertyType.h"
#import <objc/runtime.h>
#import <CoreData/CoreData.h>

/**
 *  成员变量类型（属性类型）
 */

NSString *const MGPropertyTypeChar = @"c";
NSString *const MGPropertyTypeUChar = @"C";
NSString *const MGPropertyTypeInt = @"i";
NSString *const MGPropertyTypeUInt = @"I";
NSString *const MGPropertyTypeShort = @"s";
NSString *const MGPropertyTypeUShort = @"S";
NSString *const MGPropertyTypeFloat = @"f";
NSString *const MGPropertyTypeDouble = @"d";
NSString *const MGPropertyTypeBOOL = @"B";
NSString *const MGPropertyTypeLong = @"q";
NSString *const MGPropertyTypeULong = @"";
NSString *const MGPropertyTypeLongLong = @"q";
NSString *const MGPropertyTypeULongLong = @"Q";
NSString *const MGPropertyTypeInterger = @"q";
NSString *const MGPropertyTypeUInterger = @"Q";

NSString *const MGPropertyTypeVoid = @"v";
NSString *const MGPropertyTypePointer = @"*";
NSString *const MGPropertyTypeClass = @"#";
NSString *const MGPropertyTypeBlock = @"@?";
NSString *const MGPropertyTypeId = @"@";
NSString *const MGPropertyTypeSEL = @":";
NSString *const MGPropertyTypeIvar = @"^{objc_ivar=}";
NSString *const MGPropertyTypeMethod = @"^{objc_method=}";


@implementation MGPropertyType

+ (id)getPropertyTypeWithTarget:(__kindof NSObject *)target property:(NSString *)propertyName {
    objc_property_t property = class_getProperty([target class], propertyName.UTF8String);
    const char *property_attr =  property_copyAttributeValue(property, "T");
    NSString *code = [NSString stringWithFormat:@"%s", property_attr];
    MGPropertyType *propertyType = [[MGPropertyType alloc] init];
    propertyType.code = code;
    return propertyType;
}

- (void)setCode:(NSString *)code {
    _code = code;
    
    if ([code isEqualToString:MGPropertyTypeId]) {
        _idType = YES;
    } else if (code.length == 0) {
        _KVCDisabled = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _fromFoundation = [MGPropertyType isClassFromFoundation:_typeClass];
        _numberType = [_typeClass isSubclassOfClass:[NSNumber class]];
    } else if ([code isEqualToString:MGPropertyTypeSEL] ||
               [code isEqualToString:MGPropertyTypeIvar] ||
               [code isEqualToString:MGPropertyTypeMethod]) {
        _KVCDisabled = YES;
    }
    
    // 是否为数字类型
    NSArray *numberTypes = @[
        MGPropertyTypeChar,
        MGPropertyTypeUChar,
        MGPropertyTypeInt,
        MGPropertyTypeUInt,
        MGPropertyTypeShort,
        MGPropertyTypeUShort,
        MGPropertyTypeFloat,
        MGPropertyTypeDouble,
        MGPropertyTypeBOOL,
        MGPropertyTypeLong,
        MGPropertyTypeLongLong,
        MGPropertyTypeULongLong,
        MGPropertyTypeInterger,
        MGPropertyTypeUInterger,
    ];
    
    if ([numberTypes containsObject:_code]) {
        _numberType = YES;
        if ([_code isEqualToString:MGPropertyTypeChar]) {
            _propertyNumberType = MGPropertyNumberTypeChar;
        } else if ([_code isEqualToString:MGPropertyTypeUChar]) {
            _propertyNumberType = MGPropertyNumberTypeUChar;
        } else if ([_code isEqualToString:MGPropertyTypeInt]) {
            _propertyNumberType = MGPropertyNumberTypeInt;
        } else if ([_code isEqualToString:MGPropertyTypeUInt]) {
            _propertyNumberType = MGPropertyNumberTypeUInt;
        } else if ([_code isEqualToString:MGPropertyTypeShort]) {
            _propertyNumberType = MGPropertyNumberTypeShort;
        } else if ([_code isEqualToString:MGPropertyTypeUShort]) {
            _propertyNumberType = MGPropertyNumberTypeUShort;
        } else if ([_code isEqualToString:MGPropertyTypeFloat]) {
            _propertyNumberType = MGPropertyNumberTypeFloat;
        } else if ([_code isEqualToString:MGPropertyTypeDouble]) {
            _propertyNumberType = MGPropertyNumberTypeDouble;
        } else if ([_code isEqualToString:MGPropertyTypeBOOL]) {
            _boolType = YES;
            _propertyNumberType = MGPropertyNumberTypeBool;
        } else if ([_code isEqualToString:MGPropertyTypeInterger]) {
            _propertyNumberType = MGPropertyNumberTypeNSInteger;
        } else if ([_code isEqualToString:MGPropertyTypeUInterger]) {
            _propertyNumberType = MGPropertyNumberTypeNSUInteger;
        }
    }
    
//    NSLog(@"\n");
//    NSLog(@"🔥\n _code: %@ \n _KVCDisabled:%d  \n _idType:%d \n _numberType: %d \n _boolType: %d\n _typeClass: %@ \n _fromFoundation: %d", _code, _KVCDisabled, _idType, _numberType, _boolType, _typeClass, _fromFoundation);
}

+ (BOOL)isClassFromFoundation:(Class)c {
    if (c == [NSObject class] || c == [NSManagedObject class]) return YES;
    
    static NSSet *foundationClasses;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        foundationClasses = [NSSet setWithObjects:
                             [NSURL class],
                             [NSDate class],
                             [NSValue class],
                             [NSData class],
                             [NSError class],
                             [NSArray class],
                             [NSDictionary class],
                             [NSString class],
                             [NSAttributedString class], nil];
    });
    
    __block BOOL result = NO;
    [foundationClasses enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end
