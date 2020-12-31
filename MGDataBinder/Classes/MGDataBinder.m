//
//  MGDataBinder.m
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import "MGDataBinder.h"
#import "MGDataBinderManager.h"

@implementation MGDataBinder

+ (MGDataBinder *)binder {
    MGDataBinder *binder = [[MGDataBinder alloc] init];
    return binder;
}

- (instancetype)init {
    if (self = [super init]) {
        _bindId = [self getBindId];
    }
    return self;
}

- (NSString *)getBindId {
    return [[NSString stringWithFormat:@"%p", self] substringFromIndex:2];
}

- (MGBind)bindSet {
    return ^MGDataBinder * (id target, NSString *property) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId];
        return self;
    };
}

- (MGBindBlock)bindBlockSet {
    return ^MGDataBinder * (id target, NSString *property, void(^block)(void)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId blockType:MGBlockTypeVoidVoid actionBlock:block];
        return self;
    };
}

- (MGBindBlockObj)bindBlockObjSet {
    return ^MGDataBinder * (id target, NSString *property, void(^block)(id obj)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId blockType:MGBlockTypeObjVoid actionBlock:block];
        return self;
    };
}

- (MGBindBlockReturnObj)bindBlockReturnObjSet {
    return ^MGDataBinder * (id target, NSString *property, id(^block)(void)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId blockType:MGBlockTypeVoidObj actionBlock:block];
        return self;
    };
}

- (MGBindBlockObjReturnObj)bindBlockObjReturnObjSet {
    return ^MGDataBinder * (id target, NSString *property, id(^block)(id obj)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId blockType:MGBlockTypeObjObj actionBlock:block];
        return self;
    };
}

- (MGBindEvent)bindEventSet {
    return ^MGDataBinder * (id target, NSString *property, UIControlEvents controlEvent) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId controlEvent:controlEvent];
        return self;
    };
}

- (MGBindEventBlock)bindEventBlockSet {
    return ^MGDataBinder * (id target, NSString *property, UIControlEvents controlEvent, void(^block)(void)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId controlEvent:controlEvent blockType:MGBlockTypeVoidVoid actionBlock:block];
        return self;
    };
}

- (MGBindEventBlockObj)bindEventBlockObjSet {
    return ^MGDataBinder * (id target, NSString *property, UIControlEvents controlEvent, void(^block)(id obj)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId controlEvent:controlEvent blockType:MGBlockTypeObjVoid actionBlock:block];
        return self;
    };
}

- (MGBindEventBlockReturnObj)bindeEventBlockReturnObjSet {
    return ^MGDataBinder * (id target, NSString *property, UIControlEvents controlEvent, id(^block)(void)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId controlEvent:controlEvent blockType:MGBlockTypeVoidObj actionBlock:block];
        return self;
    };
}

- (MGBindEventBlockObjReturnObj)bindEventBlockObjReturnObjSet {
    return ^MGDataBinder * (id target, NSString *property, UIControlEvents controlEvent, id(^block)(id obj)) {
        [self assertWithTarget:target property:property];
        [[MGDataBinderManager sharedBinderManager] bindTarget:target property:property bindId:self->_bindId controlEvent:controlEvent blockType:MGBlockTypeObjObj actionBlock:block];
        return self;
    };
}


- (void)assertWithTarget:(id)target property:(NSString *)property {
    NSAssert(target, @"target 不能为空");
    NSAssert(property, @"property 不能为空");
}

- (void)dealloc {
 
    NSLog(@"****************************************************** dealloc: %@", NSStringFromClass(self.class));
}

@end
