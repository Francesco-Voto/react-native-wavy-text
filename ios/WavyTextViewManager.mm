#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface WavyTextViewManager : RCTViewManager
@end

@implementation WavyTextViewManager

RCT_EXPORT_MODULE(WavyTextView)

- (UIView *)view
{
  return [[UIView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

@end