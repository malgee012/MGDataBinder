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

- (void)setTargetEntity:(MGTargetEntity *)targetEntity {
    objc_setAssociatedObject(self, @selector(targetEntity), targetEntity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MGTargetEntity *)targetEntity {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEntityObserver:(MGTargetEntityObserver *)entityObserver {
    objc_setAssociatedObject(self, @selector(entityObserver), entityObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MGTargetEntityObserver *)entityObserver {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setEntityObservers:(NSMutableArray<MGTargetEntityObserver *> *)entityObservers {
    objc_setAssociatedObject(self, @selector(entityObservers), entityObservers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<MGTargetEntityObserver *> *)entityObservers {
    return objc_getAssociatedObject(self, _cmd);
}

@end


@implementation UIViewController (MGBinder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        SEL originalSEL = NSSelectorFromString(@"dealloc");
        SEL swizzingSEL = @selector(bind_dealloc);
        [self exchangeInstanceMethodWithOriginalSel:originalSEL swizzledSel:swizzingSEL];
    });
}

+ (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSelector swizzledSel:(SEL)swizzledSelector {
    [self exchangeInstanceMethodWithOriginalClass:[self class] originalSel:originalSelector swizzledClass:[self class] swizzledSel:swizzledSelector];
}

+ (void)exchangeInstanceMethodWithOriginalClass:(Class)oClass originalSel:(SEL)originalSelector swizzledClass:(Class)sClass swizzledSel:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(oClass, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(sClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(sClass,
                                        originalSelector,
                                        method_getImplementation(swizzleMethod),
                                        method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(oClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

- (void)bind_dealloc {
    NSLog(@"dealloc__NSObject: %@", NSStringFromClass(self.class));
    [self bind_dealloc];
}


@end
