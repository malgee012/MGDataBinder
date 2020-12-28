//
//  NSObject+MGBinder.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGTargetEntity.h"
#import "MGTargetEntityObserver.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (MGBinder)

@property (nonatomic, weak) MGTargetEntity *targetEntity;

//@property (nonatomic, strong) MGTargetEntityObserver *entityObserver;
@property (nonatomic, strong, nullable) NSMutableArray <MGTargetEntityObserver *>*entityObservers;

- (NSString *)hash_id;

@end


@interface UIViewController (MGBinder)

@end

NS_ASSUME_NONNULL_END
