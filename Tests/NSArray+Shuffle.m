//
//  NSArray+Shuffle.m
//  Resort Tests
//
//  Created by Florian Ebeling on 18.05.14.
//
//

#import "NSArray+Shuffle.h"

#import "NSMutableArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (NSArray *)shuffledArray
{
    NSMutableArray *shuffled = self.mutableCopy;
    [shuffled shuffle];

    return shuffled.copy;
}

@end
