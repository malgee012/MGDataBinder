//
//  NSObject+MGBinder.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "NSObject+MGBinder.h"
#import <objc/runtime.h>

@implementation NSObject (MGBinder)

- (NSString *)hash_id {
    return [NSString stringWithFormat:@"%lx", (unsigned long)[self hash]];
}

- (void)getPropertyTypeWithProperty:(NSString *)property {
    
    // 成员属性
    objc_property_t _property = class_getProperty([self class], property.UTF8String);
    
    // 2.成员类型
    const char *property_attr =  property_copyAttributeValue(_property, "T");
    
    NSLog(@"\n");
    NSLog(@"🚀 %@ %s %s", property, property_getName(_property), property_attr);
    
    // 2.成员类型
    NSString *attrs = @(property_getAttributes(_property));
    NSUInteger dotLoc = [attrs rangeOfString:@","].location;
    NSString *code = nil;
    NSUInteger loc = 1;
    if (dotLoc == NSNotFound) { // 没有,
        code = [attrs substringFromIndex:loc];
    } else {
        code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
    }
    
    NSLog(@"code: %@   %@", code, attrs);
    
//    return MGPropertyType_NSObject;
}


@end
