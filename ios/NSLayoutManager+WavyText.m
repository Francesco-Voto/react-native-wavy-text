//
//  NSLayoutManager+WavyText.m
//  TextDecoratortRN
//
//  Created by Francesco Voto on 06/02/23.
//

#include <math.h>
#import <objc/runtime.h>
#import "NSLayoutManager+WavyText.h" 

@implementation NSLayoutManager (WavyText)

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SEL drawUnderlineSelector = @selector(drawUnderlineForGlyphRange:underlineType:baselineOffset:lineFragmentRect:lineFragmentGlyphRange:containerOrigin:);
    SEL wavy_drawUnderlineSelector =  @selector(wavy_drawUnderlineForGlyphRange:underlineType:baselineOffset:lineFragmentRect:lineFragmentGlyphRange:containerOrigin:);
   Method originalMethod = class_getInstanceMethod(self, drawUnderlineSelector);
   Method newMethod = class_getInstanceMethod(self, wavy_drawUnderlineSelector);

   BOOL methodAdded = class_addMethod([self class],
                                      drawUnderlineSelector,
                                      method_getImplementation(newMethod),
                                      method_getTypeEncoding(newMethod));

   if (methodAdded) {
   class_replaceMethod([self class],
                       wavy_drawUnderlineSelector,
                         method_getImplementation(originalMethod),
                         method_getTypeEncoding(originalMethod));
   } else {
     method_exchangeImplementations(originalMethod, newMethod);
   }
  });
  
}

- (void) wavy_drawUnderlineForGlyphRange:(NSRange)glyphRange underlineType:(NSUnderlineStyle)underlineVal baselineOffset:(CGFloat)baselineOffset lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin {
  
  if(underlineVal != 0x11 ) {
    [self wavy_drawUnderlineForGlyphRange:glyphRange underlineType:underlineVal baselineOffset:baselineOffset lineFragmentRect:lineRect lineFragmentGlyphRange:lineGlyphRange containerOrigin:containerOrigin];
    return;
  }
  
  NSTextContainer* container = [self textContainerForGlyphAtIndex:glyphRange.location effectiveRange: nil];

  CGRect rect = CGRectOffset([self boundingRectForGlyphRange:glyphRange inTextContainer: container], containerOrigin.x, containerOrigin.y);

  CGRect lastRect = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height - baselineOffset, rect.size.width, baselineOffset);
  
  [self drawUnderlineUnder: lastRect withRange: glyphRange.length];
}

- (void) drawUnderlineUnder: (CGRect) rect withRange: (NSUInteger) length  {
  CGFloat amplitude = 0.3;
  
  CGFloat width = rect.size.width;
  CGFloat height = rect.size.height;

  CGPoint origin = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));

  UIBezierPath *path = [UIBezierPath bezierPath];

  [path moveToPoint: origin];
  
  for (NSInteger i = 45; i < 360.0 * length; i = i + 5) {
    CGFloat x = origin.x + (i/360.0) * width / length;
    CGFloat y = origin.y - (sin(-i/180.0 * M_PI)) * height * amplitude;
    [path addLineToPoint:CGPointMake(x, y)];
  }

  [path stroke];
//  path.move
//
//  path.move(to: origin)
//
//  for angle in stride(from: 45.0, through: 360.0 * 10, by: 5.0) {
//      let x = origin.x + CGFloat(angle/360.0) * width / 10
//      let y = origin.y - CGFloat(sin(-angle/180.0 * Double.pi)) * height * amplitude
//      path.addLine(to: CGPoint(x: x, y: y))
//  }
}

//-         func drawUnderline(under rect: CGRect) {
//  let graphWidth: CGFloat = 1
//  let amplitude: CGFloat = 0.3
////            let path = UIBezierPath()
////            let origin = CGPoint(x: rect.minX, y: rect.minY)
////                        path.lineWidth = 1
////                        path.lineCapStyle = .round
////            path.move(to: origin)
////            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
////            path.stroke()
//
//
//  let width = rect.width
//  let height = rect.height
//
//  let origin = CGPoint(x: rect.minX, y: rect.maxY)
//
//  let path = UIBezierPath()
//  path.move(to: origin)
//
//  for angle in stride(from: 45.0, through: 360.0 * 10, by: 5.0) {
//      let x = origin.x + CGFloat(angle/360.0) * width / 10
//      let y = origin.y - CGFloat(sin(-angle/180.0 * Double.pi)) * height * amplitude
//      path.addLine(to: CGPoint(x: x, y: y))
//  }
//
////            let path = UIBezierPath()
////            path.lineWidth = 1
////            path.lineCapStyle = .round
////
////            let width = rect.width
////            let height = rect.height
////
////            let origin = CGPoint(x: rect.minX, y: rect.maxY)
////
////            path.move(to: origin)
//
////            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
////            let step = 10.0
////            for angle in stride(from: 0, through: 360, by: step) {
////                let x = origin.x
////                let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
////                path.addLine(to: CGPoint(x: x, y: y))
////
////            }
//
////            let dx = rect.size.width
////
////            let amplitude = rect.size.height
////            let period = (9 * Double.pi / 180.0);
////            let scaleXToDegrees = 1 / (rect.size.width / 360.0 / CGFloat(9))
////
////            for x in stride(from: 0, to: dx + 5, by: 5) {
////                let y = sin(period * x) * amplitude
////                let p = CGPoint(x: x + rect.origin.x, y: y + rect.origin.y)
////                if x == 0 {
////                    path.move(to: p)
////                } else {
////                    path.addLine(to: p)
////                }
////            }
////            let origin = CGPoint(x: rect.minX, y: rect.maxY )
////
////            path.move(to: origin)
//
//
////            for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
////                print(angle)
////                let x = origin.x + CGFloat(angle/360.0) * 8 * graphWidth
////                let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi))
////                path.addLine(to: CGPoint(x: x, y: y))
////            }
//
////            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
////            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//  path.stroke()
//}
@end
