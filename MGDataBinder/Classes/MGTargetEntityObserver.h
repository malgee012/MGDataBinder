//
//  MGTargetEntityObserver.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/28.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MGTargetEntity;
@interface MGTargetEntityObserver : NSObject

@property (nonatomic, copy, readonly) NSString *bindId;
@property (nonatomic, copy, readonly) NSString *signId;
@property (nonatomic, assign, getter=isAddObserver) BOOL addObserver;  // 是否添加KVO监听

- (void)addTargetObserverWithTargetEntity:(MGTargetEntity *)targetEntity;



@end

NS_ASSUME_NONNULL_END
