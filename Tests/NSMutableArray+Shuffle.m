//
//  NSMutableArray+Shuffle.m
//  Resort Tests
//
//  Created by Florian Ebeling on 18.05.14.
//
//  See: http://stackoverflow.com/a/56656/326840

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform((u_int32_t)nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
