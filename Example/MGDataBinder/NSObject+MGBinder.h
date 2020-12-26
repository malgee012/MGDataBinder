//
//  NSObject+MGBinder.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/25.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGTargetEntity.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (MGBinder)

@property (nonatomic, strong) MGTargetEntity *targetEntity;
- (NSString *)hash_id;

@end

NS_ASSUME_NONNULL_END
