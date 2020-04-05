#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *result = [[NSMutableString alloc] init];
    if (numbers.count == 0)
        return nil;
    for (int i = 0; i < numbers.count; i++) {
        NSInteger value = [numbers[i] intValue];
        if (!value)
            continue;
        NSString *sign = value < 0 ? @"-" : @"+";
        NSInteger coeff = numbers.count-1 - i;
        value = labs(value);
        if (value == 1 && coeff == 1) {
        [result appendString:[NSString stringWithFormat:@" %@ x", sign]];
        } else if (coeff == 1) {
            [result appendString:[NSString stringWithFormat:@" %@ %ldx", sign, value]];
        } else if (coeff == 0) {
            [result appendString:[NSString stringWithFormat:@" %@ %ld", sign, value]];
        } else {
            [result appendString:[NSString stringWithFormat:@" %@ %ldx^%ld", sign, value, coeff]];
        }
    }
    if ([result hasPrefix:@" + "]) {
        result = [result substringFromIndex:3];
    } else {
        [result replaceCharactersInRange:NSMakeRange(0, 3) withString:@"-"];
    }
    return result;
}
@end
