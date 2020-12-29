//
//  MGDataBinderManager.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGDataBinderHelper.h"

NS_ASSUME_NONNULL_BEGIN
@class MGTargetEntity;
@interface MGDataBinderManager : NSObject

+ (instancetype)sharedBinderManager;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId blockType:(MGBlockType)blockType actionBlock:(nullable id)actionBlock;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent blockType:(MGBlockType)blockType actionBlock:(nullable id)actionBlock;

- (NSMutableArray <MGTargetEntity *>*)getTargetEntityArrayWithBindId:(NSString *)bindId;

@end

NS_ASSUME_NONNULL_END
