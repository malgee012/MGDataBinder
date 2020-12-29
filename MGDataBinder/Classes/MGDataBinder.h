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


#define mark - 绑定

@property (nonatomic, copy, readonly) MGBind bindSet;

@property (nonatomic, copy, readonly) MGBindBlock bindBlockSet;
@property (nonatomic, copy, readonly) MGBindBlockObj bindBlockObjSet;
@property (nonatomic, copy, readonly) MGBindBlockReturnObj bindBlockReturnObjSet;
@property (nonatomic, copy, readonly) MGBindBlockObjReturnObj bindBlockObjReturnObjSet;

@property (nonatomic, copy, readonly) MGBindEvent bindEventSet;
@property (nonatomic, copy, readonly) MGBindEventBlock bindEventBlockSet;
@property (nonatomic, copy, readonly) MGBindEventBlockObj bindEventBlockObjSet;
@property (nonatomic, copy, readonly) MGBindEventBlockReturnObj bindEventBlockReturnObjSet;
@property (nonatomic, copy, readonly) MGBindEventBlockObjReturnObj bindEventBlockObjReturnObjSet;

@end

NS_ASSUME_NONNULL_END

