//
//  MGTargetModel.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGTargetModel.h"

@interface MGTargetModel ()

@property (nonatomic, assign, getter=isChangeValue) BOOL changeValue;


@end
@implementation MGTargetModel

- (NSString *)description {
    return [NSString stringWithFormat:@"🔥 %@ %@ %@ %@", [self class], ({
        NSString *str = [NSString stringWithFormat:@"%@", _target];
        str = [str componentsSeparatedByString:@";"].firstObject;
        if ([str containsString:@"<UI"]) {
            str = [str stringByAppendingString:@">"];
        }
        str;
    }), _property, [_target valueForKey:_property]];
}

- (BOOL)didChangeValue {
    return self.isChangeValue;
}

- (void)setValue:(id)value {
    if (self.propertyType.isKVCDisabled || value == nil) return;
    self.changeValue = YES;
    
    NSLog(@"--------------------------------------------------------------------- %@  %@\n", value, [value class]);
    if (self.propertyType.isNumberType) {
        value = [self wrapNumberValue:value];
    }
    [self.target setValue:value forKey:self.property];
}

- (id)wrapNumberValue:(id)value  {
    NSNumber *numberValue = nil;
    NSNumber *tempValue = (NSNumber *)value;
    switch (self.propertyType.propertyNumberType) {
        case MGPropertyNumberTypeChar:
            numberValue = [NSNumber numberWithChar:tempValue.charValue];
            break;
        case MGPropertyNumberTypeUChar:
            numberValue = [NSNumber numberWithUnsignedChar:tempValue.unsignedCharValue];
            break;
        case MGPropertyNumberTypeInt:
            numberValue = [NSNumber numberWithInt:tempValue.intValue];
            break;
        case MGPropertyNumberTypeUInt:
            numberValue = [NSNumber numberWithUnsignedInt:tempValue.unsignedIntValue];
            break;
        case MGPropertyNumberTypeShort: {
            if ([tempValue isKindOfClass:[NSString class]]) {
                numberValue = [NSNumber numberWithShort:tempValue.integerValue];
            } else {
                numberValue = [NSNumber numberWithShort:tempValue.shortValue];
            }
        }
            break;
        case MGPropertyNumberTypeUShort: {
            if ([tempValue isKindOfClass:[NSString class]]) {
                numberValue = [NSNumber numberWithShort:tempValue.integerValue];
            } else {
                numberValue = [NSNumber numberWithUnsignedShort:tempValue.unsignedShortValue];
            }
        }
            break;
        case MGPropertyNumberTypeFloat:
            numberValue = [NSNumber numberWithFloat:tempValue.floatValue];
            break;
        case MGPropertyNumberTypeDouble:
            numberValue = [NSNumber numberWithDouble:tempValue.doubleValue];
            break;
        case MGPropertyNumberTypeBool:
            numberValue = [NSNumber numberWithBool:tempValue.boolValue];
            break;
        case MGPropertyNumberTypeNSInteger:
            numberValue = [NSNumber numberWithInteger:tempValue.integerValue];
            break;
        case MGPropertyNumberTypeNSUInteger:
            if ([tempValue isKindOfClass:[NSString class]]) {
                numberValue = [NSNumber numberWithShort:tempValue.integerValue];
            } else {
                numberValue = [NSNumber numberWithUnsignedInteger:tempValue.unsignedIntegerValue];
            }
            break;
    }
    return numberValue;
}

@end
