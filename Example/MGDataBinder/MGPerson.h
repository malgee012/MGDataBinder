//
//  MGPerson.h
//  MGDataBinder_Example
//
//  Created by maling on 2020/12/27.
//  Copyright © 2020 Maling1255. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MGStudent;
@interface MGPerson : NSObject

@property (nonatomic, strong) MGStudent *student;
@property (nonatomic, copy) NSString *age;

@end

@interface MGStudent : NSObject

@property (nonatomic, copy) NSString *age;

@end

NS_ASSUME_NONNULL_END
