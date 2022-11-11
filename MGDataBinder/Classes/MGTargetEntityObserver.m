//
//  MGTargetEntityObserver.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/28.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGTargetEntityObserver.h"
#import "MGDataBinderManager.h"
#import "MGTargetEntity.h"
#import "NSObject+MGBinder.h"

static NSString * const binderTargetEntitysHashMapKey = @"binderTargetEntitysHashMap";

@interface MGTargetEntityObserver ()<NSCopying, NSMutableCopying>

@end
@implementation MGTargetEntityObserver


- (id)copyWithZone:(NSZone *)zone {
    MGTargetEntityObserver *copyObserver = [[[self class] allocWithZone:zone] init];
    [copyObserver setValue:self.bindId forKey:binder_id];
    [copyObserver setValue:self.signId forKey:sign_id];
    copyObserver.addObserver = self.addObserver;
    return copyObserver;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    MGTargetEntityObserver *copyObserver = [[[self class] allocWithZone:zone] init];
    [copyObserver setValue:self.bindId forKey:binder_id];
    [copyObserver setValue:self.signId forKey:sign_id];
    copyObserver.addObserver = self.addObserver;
    return copyObserver;
}

- (void)addTargetObserverWithTargetEntity:(MGTargetEntity *)targetEntity {
    NSMutableArray <MGTargetEntityObserver *>*entityObservers = ((NSObject *)(targetEntity.target)).entityObservers;
    targetEntity.observer.addObserver = YES;
    NSArray *signArray = [entityObservers valueForKeyPath:sign_id];
    NSInteger index = [signArray indexOfObject:targetEntity.signId];
    MGTargetEntityObserver *entityObserver = entityObservers[index];
    entityObserver.addObserver = YES;
    
    NSLog(@"🚀🚀KVO     %@    %@", targetEntity, self);
    [targetEntity.target addObserver:self forKeyPath:targetEntity.property options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)targetEntity];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    MGTargetEntity *targetEntity = (__bridge id)(context);
    if (targetEntity.didChangeValue) {
        return;
    }
    
    id oldValue = change[NSKeyValueChangeOldKey];
    id newValue = change[NSKeyValueChangeNewKey];
    
    NSLog(@"\n------------------------------------------------------------------------------------------------------------------------------------------\n");
    NSLog(@"oldValue: %@  type: %@", oldValue, [oldValue class]);
    NSLog(@"newValue: %@  type: %@", newValue, [newValue class]);
    
    if ([self compare:newValue another:oldValue]) {
        return;
    }
    
    [targetEntity updateValue:newValue withTargetEntity:targetEntity];
}

- (BOOL)compare:(id)value another:(id)anotherValue {
    return [value isEqual:anotherValue];
}


- (void)unbindWithBindId:(NSString *)bindId {
    if (!bindId) {
        return;
    }
    NSMutableDictionary<NSString *, NSMutableArray<MGTargetEntity *>*>*binderTargetEntitysHashMap = [[MGDataBinderManager sharedBinderManager] valueForKey:binderTargetEntitysHashMapKey];
    NSMutableArray <MGTargetEntity *>*targetEntitysArray = binderTargetEntitysHashMap[bindId];
    if (!targetEntitysArray || !targetEntitysArray.count) {
        return;
    }
    for (MGTargetEntity *targetEntity in targetEntitysArray) {
        
        NSMutableArray <MGTargetEntityObserver *>*observers = ((NSObject *)(targetEntity.target)).entityObservers;
        if (!observers || !observers.count) continue;
        
        for (MGTargetEntityObserver *observer in observers) {
            if (targetEntity.target && observer && observer.isAddObserver && !targetEntity.isRemoveObserver) {
                NSLog(@"🌶🌶释放 %@", targetEntity);
                [targetEntity.target removeObserver:targetEntity.observer forKeyPath:targetEntity.property context:(__bridge void * _Nullable)targetEntity];
                targetEntity.removeObserver = YES;
            }
        }
    }
    
    [targetEntitysArray removeAllObjects];
    binderTargetEntitysHashMap[bindId] = nil;
}

- (void)dealloc {
//    NSLog(@"****************************************************** dealloc: %@", self);
    [self unbindWithBindId:self.bindId];
}

/**
  UIViewController 释放 -> UI控件释放(weak  targetEntity释放(Observer释放) ) ->  通过 bindid释放所有
 */


@end
