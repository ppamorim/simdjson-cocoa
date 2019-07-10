//
//  NSObject+simdParser.m
//  simdjson-cocoa
//
//  Created by Pedro Paulo de Amorim on 10/07/2019.
//

#import "SimdParser.h"

@implementation SimdParser
/* method returning the max between two numbers */
- (int)max:(int)num1 andNum2:(int)num2 {
  
  /* local variable declaration */
  int result;
  
  if (num1 > num2) {
    result = num1;
  } else {
    result = num2;
  }
  
  return result;
}
@end
