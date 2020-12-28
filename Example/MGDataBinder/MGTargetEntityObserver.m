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

- (void)addTargetObserverWithTargetEntity:(MGTargetEntity *)targetEntity {
 
    // 这里
    NSMutableArray <MGTargetEntityObserver *>*entityObservers = ((NSObject *)(targetEntity.target)).entityObservers;
    targetEntity.observer.addObserver = YES;
    NSArray *signArray = [entityObservers valueForKeyPath:@"signId"];
    NSInteger index = [signArray indexOfObject:targetEntity.signId];
    MGTargetEntityObserver *entityObsetver = entityObservers[index];
    entityObsetver.addObserver = YES;
    
   NSLog(@" %@   %@ ::::::::: %@  ::::::::: %@", targetEntity.target, targetEntity.signId, [entityObservers valueForKeyPath:@"signId"], self);
    
    
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
    
    [self updateValue:newValue withTargetEntity:targetEntity];
}

- (void)updateValue:(id)newValue withTargetEntity:(MGTargetEntity *)targetEntity {
    
    NSMutableArray <MGTargetEntity *>*targetEntitysArray = [[MGDataBinderManager sharedBinderManager] getTargetModelArrayWithBindId:targetEntity.bindId];
    
    for (MGTargetEntity *model in targetEntitysArray) {
    
        [model setValue:newValue];
        
        NSLog(@"::: %@ ", model);
    }
    
    [targetEntitysArray setValue:@(NO) forKeyPath:@"changeValue"];
}

- (BOOL)compare:(id)value another:(id)anotherValue {
    return [value isEqual:anotherValue];
}

- (void)dealloc {
 
    
    NSLog(@"****************************************************** dealloc: %@", NSStringFromClass(self.class));
    [[MGDataBinderManager sharedBinderManager] unbindWithBindId:self.bindId];
}

@end
