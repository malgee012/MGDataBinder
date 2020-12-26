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

@property (nonatomic, copy, readonly) MGBinderTargetBlockReturn binderTargetBlockReturnSet;

@property (nonatomic, copy, readonly) MGBinderTargetEvent binderTargetEventSet;

@end

NS_ASSUME_NONNULL_END
