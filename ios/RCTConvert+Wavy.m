//
//  RCTConvert+Wavy.m
//  TextDecoratortRN
//
//  Created by Francesco Voto on 28/03/22.
//

#import "RCTConvert+Wavy.h"

@implementation RCTConvert (Wavy)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

RCT_ENUM_CONVERTER(
    NSUnderlineStyle,
    (@{
      @"solid" : @(NSUnderlineStyleSingle),
      @"double" : @(NSUnderlineStyleDouble),
      @"dotted" : @(NSUnderlinePatternDot | NSUnderlineStyleSingle),
      @"dashed" : @(NSUnderlinePatternDash | NSUnderlineStyleSingle),
      @"wavy" : @0x11,
    }),
    NSUnderlineStyleSingle,
    integerValue)

#pragma clang diagnostic pop
@end
