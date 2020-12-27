//
//  MGDataBinderManager.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGDataBinderManager.h"
#import "MGTargetEntity.h"
#import "NSObject+MGBinder.h"
#import <objc/runtime.h>
#import "MGPropertyType.h"

@interface MGDataBinderManager ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<MGTargetEntity *>*> *binderTargetEntitysHashMap;

@end

@implementation MGDataBinderManager

+ (instancetype)sharedBinderManager {
    static MGDataBinderManager * _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedBinderManager];
}

#pragma mark - 绑定

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId {
    [self bindTarget:target property:property bindId:bindId controlEvent:0];
}

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId blockType:(MGBlockType)blockType actionBlock:(id)actionBlock {
    MGTargetEntity *targetEntity = [self getTargetModelWidthTarget:target property:property bindId:bindId controlEvent:0 blockType:blockType actionBlock:actionBlock];
    [self bindTargetEntity:targetEntity];
}

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent {
    [self bindTarget:target property:property bindId:bindId controlEvent:controlEvent blockType:MGBlockTypeNone actionBlock:nil];
}

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent blockType:(MGBlockType)blockType actionBlock:(id)actionBlock {
    MGTargetEntity *targetEntity = [self getTargetModelWidthTarget:target property:property bindId:bindId controlEvent:controlEvent blockType:blockType actionBlock:actionBlock];
    [self bindTargetEntity:targetEntity];
}

#pragma mark - observe

- (void)bindTargetEntity:(MGTargetEntity *)targetEntity {
    if (!targetEntity) {
        return;
    }
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
    
    NSMutableArray <MGTargetEntity *>*modelsArray = [self getTargetModelArrayWithBindId:targetEntity.bindId];
    
    for (MGTargetEntity *model in modelsArray) {
    
        [model setValue:newValue];
        
        NSLog(@"::: %@ ", model);
    }
    
    [modelsArray setValue:@(NO) forKeyPath:@"changeValue"];
}

- (BOOL)compare:(id)value another:(id)anotherValue {
    return [value isEqual:anotherValue];
}


#pragma mark - Private Method

- (MGTargetEntity *)getTargetModelWidthTarget:(id)target
                                    property:(NSString *)property
                                      bindId:(NSString *)bindId
                                controlEvent:(UIControlEvents)controlEvent
                                   blockType:(MGBlockType)blockType
                                 actionBlock:(id _Nullable)actionBlock {

    NSMutableArray <MGTargetEntity *>*modelsArray = [self getTargetModelArrayWithBindId:bindId];
    NSString *signId = [self getSignIdWithTarget:target property:property bindId:bindId];
    NSMutableArray *array = [modelsArray valueForKeyPath:@"signId"];
    if ([array containsObject:signId]) {
        return nil;
    }
    
    MGTargetEntity *targetEntity = [[MGTargetEntity alloc] init];
    [targetEntity setValue:signId forKey:@"signId"];
    [targetEntity setValue:bindId forKey:@"bindId"];
    targetEntity.target = target;
    targetEntity.property = property;
    targetEntity.propertyType = [MGPropertyType getPropertyTypeWithTarget:target property:property];
    targetEntity.actionBlock = actionBlock;
    targetEntity.blockType = blockType;
    targetEntity.controlEvent = controlEvent;
    ((NSObject *)targetEntity.target).targetEntity = targetEntity;
    [modelsArray addObject:targetEntity];
    return targetEntity;
}


- (NSMutableArray <MGTargetEntity *>*)getTargetModelArrayWithBindId:(NSString *)bindId {
    NSMutableArray <MGTargetEntity *>*modelsArray = self.binderTargetEntitysHashMap[bindId];
    if (!modelsArray) {
        modelsArray = [[NSMutableArray array] init];
        self.binderTargetEntitysHashMap[bindId] = modelsArray;
    }
    return modelsArray;
}

- (NSString *)getSignIdWithTarget:(NSObject *)target property:(NSString *)property bindId:(NSString *)bindId {
    return [NSString stringWithFormat:@"%@_%@_%@", bindId, target.hash_id, property.hash_id];
}

#define mark - Setter & Getter

- (NSMutableDictionary<NSString *, NSMutableArray<MGTargetEntity *>*>*)binderTargetEntitysHashMap {
    if (!_binderTargetEntitysHashMap) {
        _binderTargetEntitysHashMap = [[NSMutableDictionary alloc] init];
    }
    return _binderTargetEntitysHashMap;;
}


- (void)dealloc {
    
    // [targetEntity.target addObserver:self forKeyPath:targetEntity.property options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)targetEntity];
//     [targetEntity.target removeObserver:self forKeyPath:targetEntity.property context:(__bridge void * _Nullable)targetEntity];
}

@end
