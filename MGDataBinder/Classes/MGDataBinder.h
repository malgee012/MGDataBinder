//
//  MGDataBinder.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGDataBinderHelper.h"



NS_ASSUME_NONNULL_BEGIN

@interface MGDataBinder : NSObject

@property (nonatomic, copy, readonly) NSString *bindId;
+ (MGDataBinder *)binder;
+ (void)setEnableLog:(BOOL)enable;
#define mark - 绑定

@property (nonatomic, copy, readonly) MGBind bindSet;

@property (nonatomic, copy, readonly) MGBindBlock bindBlockSet;
@property (nonatomic, copy, readonly) MGBindBlockObj bindBlockObjSet;
@property (nonatomic, copy, readonly) MGBindBlockReturnObj bindBlockRObjSet;
@property (nonatomic, copy, readonly) MGBindBlockObjReturnObj bindBlockObjRObjSet;

@property (nonatomic, copy, readonly) MGBindEvent bindEventSet;
@property (nonatomic, copy, readonly) MGBindEventBlock bindEventBlockSet;       // 无参数无返回值
@property (nonatomic, copy, readonly) MGBindEventBlockObj bindEventBlockObjSet;         // 有参数无返回值
@property (nonatomic, copy, readonly) MGBindEventBlockReturnObj bindEventBlockRObjSet;     // 无参数有返回值
@property (nonatomic, copy, readonly) MGBindEventBlockObjReturnObj bindEventBlockObjRObjSet;        // 有参数有返回值

@end


UIKIT_STATIC_INLINE MGDataBinder * Binder() {
    MGDataBinder *binder = [[MGDataBinder alloc] init];
    return binder;
}


NS_ASSUME_NONNULL_END

