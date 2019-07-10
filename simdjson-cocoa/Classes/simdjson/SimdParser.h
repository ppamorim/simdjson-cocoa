//
//  NSObject+simdParser.h
//  simdjson-cocoa
//
//  Created by Pedro Paulo de Amorim on 10/07/2019.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimdParser : NSObject {
}
- (bool)isOk;
- (size_t)tapeLocation;
- (size_t)tapeLength;
- (size_t)depth;
- (uint8_t)scopeType;
- (bool)moveFoward;
- (uint8_t)type;
- (int64_t)integer;
- (NSString *)string;
- (uint32_t)stringLength;
- (double)double;
- (bool)isObjectOrArray;
- (bool)isObject;
- (bool)isArray;
- (bool)isString;
- (bool)isInteger;
- (bool)isDouble;
- (bool)isTrue;
- (bool)isFalse;
- (bool)isNULL;
- (bool)isObjectOrArray:(uint8_t)atype;
- (bool)moveToKey:(nonnull NSString *)akey;
- (bool)moveToKey:(nonnull NSString *)akey length:(int)alength;
- (void)moveToValue;
- (bool)next;
- (bool)previous;
- (bool)up;
- (bool)down;
- (void)toStartScope;
- (int64_t)int:(nonnull NSString *)akey;
- (double)double:(nonnull NSString *)akey;
- (NSString *)string:(nonnull NSString *)akey;
+ (SimdParser*)parseJson:(nonnull NSURL *)url;
@end

NS_ASSUME_NONNULL_END
