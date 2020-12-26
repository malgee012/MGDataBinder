//
//  MGDataBinderManager.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGDataBinderManager : NSObject

+ (instancetype)sharedBinderManager;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId block:(void(^_Nullable)(id _Nullable obj))actionBlock;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId returnBlock:(id(^_Nullable)(id _Nullable obj))actionBlock;
- (void)bindTarget:(id)target property:(NSString *)property bindId:(NSString *)bindId controlEvent:(UIControlEvents)controlEvent;

@end

NS_ASSUME_NONNULL_END
