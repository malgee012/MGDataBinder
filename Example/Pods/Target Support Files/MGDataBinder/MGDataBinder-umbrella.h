#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MGDataBinder.h"
#import "MGDataBinderHelper.h"
#import "MGDataBinderManager.h"
#import "MGPropertyType.h"
#import "MGTargetEntity.h"
#import "MGTargetEntityObserver.h"
#import "NSObject+MGBinder.h"

FOUNDATION_EXPORT double MGDataBinderVersionNumber;
FOUNDATION_EXPORT const unsigned char MGDataBinderVersionString[];

