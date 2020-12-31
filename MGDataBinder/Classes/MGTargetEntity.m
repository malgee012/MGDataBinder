//
//  MGTargetEntity.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGTargetEntity.h"
#import "MGDataBinderManager.h"
#import "NSObject+MGBinder.h"

@interface MGTargetEntity ()

@property (nonatomic, copy, readonly) MGBlock;
@property (nonatomic, copy, readonly) MGBlockObj;
@property (nonatomic, copy, readonly) MGBlockReturnObj;
@property (nonatomic, copy, readonly) MGBlockObjReturnObj;
@property (nonatomic, assign, getter=isChangeValue) BOOL changeValue;

@end
@implementation MGTargetEntity

- (NSString *)description {
    return [NSString stringWithFormat:@"%@  %@      <%@:%p> %@ %@ %@ observers:%@", _bindId, _signId, [self class], self, ({
        NSString *str = [NSString stringWithFormat:@"%@", _target];
        str = [str componentsSeparatedByString:@";"].firstObject;
        if ([str containsString:@"<UI"]) {
            str = [str stringByAppendingString:@">"];
        }
        str;
    }), _property, [_target valueForKeyPath:_property], ((NSObject *)_target).entityObservers];
}

- (BOOL)didChangeValue {
    return self.isChangeValue;
}

- (void)setBlockType:(MGBlockType)blockType {
    _blockType = blockType;
    switch (blockType) {
        case MGBlockTypeVoidVoid:
            _block1 = self.actionBlock;
            break;
        case MGBlockTypeVoidObj:
            _block3 = self.actionBlock;
            break;
        case MGBlockTypeObjVoid:
            _block2 = self.actionBlock;
            break;
        case MGBlockTypeObjObj:
            _block4 = self.actionBlock;
            break;
        default: {
            _block1 = nil;
            _block2 = nil;
            _block3 = nil;
            _block4 = nil;
        }
            break;
    }
}

- (void)setControlEvent:(UIControlEvents)controlEvent {
    if (controlEvent <= 0) {
        _controlAction = NO;
        return;
    }
    _controlAction = YES;
    _controlEvent = controlEvent;
    [self.target addTarget:self action:@selector(binderActionEvent:) forControlEvents:controlEvent];
}

- (void)binderActionEvent:(id)target {
    id value = [self handelActionBlockWithValue:[target valueForKeyPath:self.property]];
    if (!value) {
        return;
    }

    MGTargetEntity *targetEntity = ((NSObject *)target).targetEntity;
    [targetEntity updateValue:value withTargetEntity:targetEntity];

    NSLog(@"-----------------------------UI主动改变后的值：： %@   %@", [target valueForKeyPath:self.property], [[target valueForKeyPath:self.property] class]);
}

- (void)updateValue:(id)newValue withTargetEntity:(MGTargetEntity *)targetEntity {
    NSMutableArray <MGTargetEntity *>*targetEntitysArray = [[MGDataBinderManager sharedBinderManager] getTargetEntityArrayWithBindId:targetEntity.bindId];
    for (MGTargetEntity *entity in targetEntitysArray) {
        [entity setValue:newValue];
        NSLog(@"::: %@ ", entity);
    }

    [targetEntitysArray setValue:@(NO) forKeyPath:@"changeValue"];
}

- (id)handelActionBlockWithValue:(id)value {
    if (self.blockType == MGBlockTypeVoidVoid) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.block1();
        });
    } else if (self.blockType == MGBlockTypeVoidObj) {
        return self.block3();
    } else if (self.blockType == MGBlockTypeObjVoid) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.block2(value);
        });
    } else if (self.blockType == MGBlockTypeObjObj) {
        return self.block4(value);
    }
    return value;
}

- (void)setValue:(id)value {
    value = [self handelActionBlockWithValue:value];
    if (self.propertyType.isKVCDisabled || value == nil) return;
    self.changeValue = YES;
    
//    NSLog(@"************************************************ %@  %@", value, [value class]);
    if (self.propertyType.isNumberType) {
        value = [self wrapNumberValue:value];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        value = [NSString stringWithFormat:@"%@", value];
    }
    
//    NSLog(@"------------------------------------------------ %@  %@  %@  %@ ", value, [value class], self.target, self.property);
//    NSLog(@"\n");
    
    [self.target setValue:value forKeyPath:self.property];
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

- (void)dealloc {
 
//    NSLog(@"****************************************************** dealloc: %@", NSStringFromClass(self.class));
}

@end
