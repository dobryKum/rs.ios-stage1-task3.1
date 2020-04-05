#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    NSInteger m = [array[0] intValue];
    NSInteger n = [array[1] intValue];
    
    for (int i = 1; i < n; i++) {
        if (m == (tgamma(n+1) / (tgamma(i+1) * tgamma((n - i)+1)))) {
            return [NSNumber numberWithInt:i];
        }
    }
    
    return nil;
}
@end
