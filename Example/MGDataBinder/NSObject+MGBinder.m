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



@end
