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

@property (nonatomic, copy, readonly) MGBinderTarget binderTargetSet;

@property (nonatomic, copy, readonly) MGBinderTargetBlock binderTargetBlockSet;
@property (nonatomic, copy, readonly) MGBinderTargetBlockObj binderTargetBlockObjSet;
@property (nonatomic, copy, readonly) MGBinderTargetBlockReturnObj binderTargetBlockReturnObjSet;
@property (nonatomic, copy, readonly) MGBinderTargetBlockObjReturnObj binderTargetBlockObjReturnObjSet;

@property (nonatomic, copy, readonly) MGBinderTargetEvent binderTargetEventSet;
@property (nonatomic, copy, readonly) MGBinderTargetEventBlock binderTargetEventBlockSet;
@property (nonatomic, copy, readonly) MGBinderTargetEventBlockObj binderTargetEventBlockObjSet;
@property (nonatomic, copy, readonly) MGBinderTargetEventBlockReturnObj binderTargetEventBlockReturnObjSet;
@property (nonatomic, copy, readonly) MGBinderTargetEventBlockObjReturnObj binderTargetEventBlockObjReturnObjSet;

@end

NS_ASSUME_NONNULL_END

