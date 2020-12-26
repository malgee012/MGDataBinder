//
//  MGDataBinderManager.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGDataBinderManager.h"
#import "MGTargetModel.h"
#import "NSObject+MGBinder.h"
#import <objc/runtime.h>
#import "MGPropertyType.h"

@interface MGDataBinderManager ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<MGTargetModel *>*> *binderTargetModelsHashMap;

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
    [self bindTarget:target property:property bindId:bindId controlEvent:-1];
}

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId blockType:(MGBlockType)blockType actionBlock:(id)actionBlock {
    MGTargetModel *targetModel = [self getTargetModelWidthTarget:target property:property bindId:bindId controlEvent:-1 blockType:blockType actionBlock:actionBlock];
    [self bindTargetModel:targetModel];
}

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent {
    [self bindTarget:target property:property bindId:bindId controlEvent:controlEvent blockType:MGBlockTypeNone actionBlock:nil];
}

- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent blockType:(MGBlockType)blockType actionBlock:(id)actionBlock {
    MGTargetModel *targetModel = [self getTargetModelWidthTarget:target property:property bindId:bindId controlEvent:controlEvent blockType:MGBlockTypeNone actionBlock:nil];
    [self bindTargetModel:targetModel];
}

#pragma mark - observe

- (void)bindTargetModel:(MGTargetModel *)targetModel {
    if (!targetModel) {
        return;
    }
    [targetModel.target addObserver:self forKeyPath:targetModel.property options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)targetModel];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    MGTargetModel *targetModel = (__bridge id)(context);
    if (targetModel.didChangeValue) {
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
    
    [self updateValue:newValue withTargetModel:targetModel];
}

- (void)updateValue:(id)newValue withTargetModel:(MGTargetModel *)targetModel {
    
    NSMutableArray <MGTargetModel *>*modelsArray = [self getTargetModelArrayWithBindId:targetModel.bindId];
    
    for (MGTargetModel *model in modelsArray) {
    
        [model setValue:newValue];
        
        NSLog(@"::: %@ ", model);
    }
    
    [modelsArray setValue:@(NO) forKeyPath:@"changeValue"];
}

- (BOOL)compare:(id)value another:(id)anotherValue {
    

    return [value isEqual:anotherValue];
}

#pragma mark - Private Method

- (MGTargetModel *)getTargetModelWidthTarget:(id)target
                                    property:(NSString *)property
                                      bindId:(NSString *)bindId
                                controlEvent:(UIControlEvents)controlEvent
                                   blockType:(MGBlockType)blockType
                                 actionBlock:(id _Nullable)actionBlock {

    NSMutableArray <MGTargetModel *>*modelsArray = [self getTargetModelArrayWithBindId:bindId];
    NSString *signId = [self getSignIdWithTarget:target property:property bindId:bindId];
    NSMutableArray *array = [modelsArray valueForKeyPath:@"signId"];
    if ([array containsObject:signId]) {
        return nil;
    }
    
    MGTargetModel *targetModel = [[MGTargetModel alloc] init];
    [targetModel setValue:signId forKey:@"signId"];
    [targetModel setValue:bindId forKey:@"bindId"];
    targetModel.target = target;
    targetModel.property = property;
    targetModel.propertyType = [MGPropertyType getPropertyTypeWithTarget:target property:property];
    targetModel.controlEvent = controlEvent;
    targetModel.actionBlock = actionBlock;
    targetModel.blockType = blockType;
    [modelsArray addObject:targetModel];
    return targetModel;
}


- (NSMutableArray <MGTargetModel *>*)getTargetModelArrayWithBindId:(NSString *)bindId {
    NSMutableArray <MGTargetModel *>*modelsArray = self.binderTargetModelsHashMap[bindId];
    if (!modelsArray) {
        modelsArray = [[NSMutableArray array] init];
        self.binderTargetModelsHashMap[bindId] = modelsArray;
    }
    return modelsArray;
}

- (NSString *)getSignIdWithTarget:(NSObject *)target property:(NSString *)property bindId:(NSString *)bindId {
    return [NSString stringWithFormat:@"%@_%@_%@", bindId, target.hash_id, property.hash_id];
}

#define mark - Setter & Getter

- (NSMutableDictionary<NSString *, NSMutableArray<MGTargetModel *>*>*)binderTargetModelsHashMap {
    if (!_binderTargetModelsHashMap) {
        _binderTargetModelsHashMap = [[NSMutableDictionary alloc] init];
    }
    return _binderTargetModelsHashMap;;
}


@end
