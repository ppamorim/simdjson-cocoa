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

#import "datasource.h"
#import "MessageParser.h"
#import "simdjson.h"
#import "SimdParser.hh"

FOUNDATION_EXPORT double simdjson_cocoaVersionNumber;
FOUNDATION_EXPORT const unsigned char simdjson_cocoaVersionString[];

