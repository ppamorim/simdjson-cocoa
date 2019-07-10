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

- (bool)isObject {
  return iterator->is_object();
}

- (bool)isArray {
  return iterator->is_array();
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
  if (iterator == NULL || !iterator->isOk()) {
    return NULL;
  }
  iterator->print(std::cout); //prints {
  bool moved = iterator->move_to_key([akey UTF8String], [akey length]); //key: name
  std::cout << "moved:" << moved << std::endl;
  if (moved) {
    return [NSString stringWithUTF8String:iterator->get_string()];
  }
  return NULL;
}

+ (SimdParser*)parseJson:(nonnull NSURL *)url {
  
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
@end
