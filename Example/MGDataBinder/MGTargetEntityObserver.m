//
//  MGTargetEntityObserver.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/28.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGTargetEntityObserver.h"
#import "MGDataBinderManager.h"

@interface MGTargetEntityObserver ()<NSCopying, NSMutableCopying>

@end
@implementation MGTargetEntityObserver


- (id)copyWithZone:(NSZone *)zone {
    MGTargetEntityObserver *copyObserver = [[[self class] allocWithZone:zone] init];
    [copyObserver setValue:self.bindId forKey:@"bindId"];
    [copyObserver setValue:self.signId forKey:@"signId"];
    copyObserver.addObserver = self.addObserver;
    return copyObserver;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    MGTargetEntityObserver *copyObserver = [[[self class] allocWithZone:zone] init];
    [copyObserver setValue:self.bindId forKey:@"bindId"];
    [copyObserver setValue:self.signId forKey:@"signId"];
    copyObserver.addObserver = self.addObserver;
    return copyObserver;
}

- (void)dealloc {
 
    
    NSLog(@"****************************************************** dealloc: %@", NSStringFromClass(self.class));
    [[MGDataBinderManager sharedBinderManager] unbindWithBindId:self.bindId];
}

@end
