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
- (bool)isObject;
- (bool)isArray;
- (bool)moveToKey:(nonnull NSString *)akey;
- (bool)moveToKey:(nonnull NSString *)akey length:(int)alength;
- (int64_t)int:(nonnull NSString *)akey;
- (double)double:(nonnull NSString *)akey;
- (NSString *)string:(nonnull NSString *)akey;
+ (SimdParser*)parseJson:(nonnull NSURL *)url;
@end

NS_ASSUME_NONNULL_END
