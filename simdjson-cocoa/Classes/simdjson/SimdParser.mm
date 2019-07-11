//
//  NSObject+simdParser.m
//  simdjson-cocoa
//
//  Created by Pedro Paulo de Amorim on 10/07/2019.
//

#import "SimdParser.h"
#import <os/log.h>
#include "simdjson.h"

@implementation SimdParser

simdjson::ParsedJson::iterator *iterator;

- (instancetype)initWithIterator: (simdjson::ParsedJson::iterator)aiterator {
  self = [super init];
  iterator = new simdjson::ParsedJson::iterator(aiterator);
  return self;
}

- (bool)isOk {
  return iterator->isOk();
}

- (size_t)tapeLocation {
  return iterator->get_tape_location();
}

- (size_t)tapeLength {
  return iterator->get_tape_length();
}

- (size_t)depth {
  return iterator->get_depth();
}

- (uint8_t)scopeType {
  return iterator->get_scope_type();
}

- (bool)moveFoward {
  return iterator->move_forward();
}

- (uint8_t)type {
  return iterator->get_type();
}

- (int64_t)integer {
  return iterator->get_type();
}

- (NSString *)string {
  return [NSString stringWithUTF8String:iterator->get_string()];
}

- (uint32_t)stringLength {
  return iterator->get_string_length();
}

- (double)double {
  return iterator->get_double();
}

- (bool)isObjectOrArray {
  return iterator->is_object_or_array();
}

- (bool)isObject {
  return iterator->is_object();
}

- (bool)isArray {
  return iterator->is_array();
}

- (bool)isString {
  return iterator->is_string();
}

- (bool)isInteger {
  return iterator->is_integer();
}

- (bool)isDouble {
  return iterator->is_double();
}

- (bool)isTrue {
  return iterator->is_true();
}

- (bool)isFalse {
  return iterator->is_false();
}

- (bool)isNULL {
  return iterator->is_null();
}

- (bool)isObjectOrArray:(uint8_t)atype {
  return iterator->is_object_or_array(atype);
}

- (bool)moveToKey:(nonnull NSString *)akey {
  return iterator->move_to_key([akey UTF8String]);
}

- (bool)moveToKey:(nonnull NSString *)akey length:(int)alength {
  return iterator->move_to_key([akey UTF8String], alength);
}

- (void)moveToValue {
  return iterator->move_to_value();
}

- (bool)next {
  return iterator->next();
}

- (bool)previous {
  return iterator->prev();
}

- (bool)up {
  return iterator->up();
}

- (bool)down {
  return iterator->down();
}

- (void)toStartScope {
  return iterator->to_start_scope();
}

- (int64_t)int:(nonnull NSString *)akey {
  iterator->move_to_key([akey UTF8String]);
  return iterator->get_integer();
}

- (double)double:(nonnull NSString *)akey {
  iterator->move_to_key([akey UTF8String]);
  return iterator->get_double();
}

- (NSString *)string:(nonnull NSString *)akey {
  iterator->move_to_key([akey UTF8String]);
  return [NSString stringWithUTF8String:iterator->get_string()];;
}

+ (SimdParser*)parseWithURL:(nonnull NSURL *)url {
  
  simdjson::padded_string p = simdjson::get_corpus([[url path] UTF8String]);
  simdjson::ParsedJson pj;
  
  bool isok = pj.allocateCapacity(p.size());
  if (!isok) {
    return NULL;
  }
  
  const int res = json_parse(p, pj);
  if (res != 0) { // parsing is done!
    // You can use the "simdjson/simdjson.h" header to access the error message
    std::cout << "Error parsing:" << simdjson::errorMsg(res) << std::endl;
  }

  simdjson::ParsedJson::iterator pjh(pj);
  if (!pjh.isOk()) {
    std::cerr << " Could not iterate parsed result. " << std::endl;
    return NULL;
  }
  
  return [[SimdParser alloc] initWithIterator:pjh];
}

+ (SimdParser*)parseWithData:(nonnull NSData *)adata {
  uint8_t * buffer = (uint8_t  * )[adata bytes];
  NSInteger length = [adata length] / sizeof(uint8_t);
  simdjson::ParsedJson pj = simdjson::build_parsed_json(buffer, length, true);
  simdjson::ParsedJson::iterator pjh(pj);
  if (!pjh.isOk()) {
    std::cerr << " Could not iterate parsed result. " << std::endl;
    return NULL;
  }
  return [[SimdParser alloc] initWithIterator:pjh];
}

+ (SimdParser*)parseWithInputStream:(nonnull NSInputStream *)ainputStream size:(size_t)asize {
  [ainputStream open];
  NSInteger result;
  uint8_t buffer[1024];
  
  simdjson::ParsedJson pj;
  
  bool isok = pj.allocateCapacity(asize);
  if (!isok) {
    return NULL;
  }
  
  while((result = [ainputStream read:buffer maxLength:1024]) != 0) {
    simdjson::json_parse(buffer, asize, pj);
  }
  [ainputStream close];

  simdjson::ParsedJson::iterator pjh(pj);
  if (!pjh.isOk()) {
    std::cerr << " Could not iterate parsed result. " << std::endl;
    return NULL;
  }
  return [[SimdParser alloc] initWithIterator:pjh];
}

+ (SimdParser*)parseWithBuffer:(nonnull uint8_t *)abuffer size:(size_t)asize {
  simdjson::ParsedJson pj = simdjson::build_parsed_json(abuffer, asize, true);
  simdjson::ParsedJson::iterator pjh(pj);
  if (!pjh.isOk()) {
    std::cerr << " Could not iterate parsed result. " << std::endl;
    return NULL;
  }
  return [[SimdParser alloc] initWithIterator:pjh];
}

@end
