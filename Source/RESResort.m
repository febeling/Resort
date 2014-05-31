//
//  RESResort.m
//  Resort
//
//  Created by Florian Ebeling on 18.05.14.
//
//

#import "RESResort.h"

@implementation RESResort

+ (NSComparator)reverseComparator:(NSComparator)comparator
{
    return ^NSComparisonResult (NSObject *a, NSObject *b) {
        return comparator(a, b) * -1;
    };
}

+ (NSComparator)compoundComparatorWithComparatorArray:(NSArray *)comparators
{
    NSParameterAssert(comparators != nil);
    NSParameterAssert(comparators.count > 0);

    return ^NSComparisonResult (NSObject *a, NSObject *b) {
        NSComparisonResult comparison = 0;
        for(NSComparator comparator in comparators) {
            comparison = comparator(a, b);
            if(comparison != NSOrderedSame) return comparison;
        }

        return comparison;
    };
}

+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath nilComparison:(RESNilComparison)nilComparison
{
    return ^NSComparisonResult (NSObject *a, NSObject *b) {
        if(a == NSNull.null) a = nil;
        if(b == NSNull.null) b = nil;

        NSObject *aRank = [a valueForKeyPath:keyPath];
        NSObject *bRank = [b valueForKeyPath:keyPath];

        if(aRank == nil || bRank == nil) {
            switch (nilComparison) {
                case RESNilComparisonThrows:
                    [NSException raise:@"Nil comparison" format:@"comparison with nil is undefined"];
                    break;
                case RESNilComparisonLess:
                    if(aRank == nil && bRank == nil) {
                        return NSOrderedSame;
                    } else if(aRank == nil) {
                        return NSOrderedAscending;
                    }
                    return NSOrderedDescending;
                case RESNilComparisonMore:
                    if(aRank == nil && bRank == nil) {
                        return NSOrderedSame;
                    } else if(aRank == nil) {
                        return NSOrderedDescending;
                    }
                    return NSOrderedAscending;
            }
        }

        if([aRank isKindOfClass:NSString.class] && [bRank isKindOfClass:NSString.class]) {
            return [aRank.description compare:bRank.description];
        } else if([aRank isKindOfClass:NSNumber.class] && [bRank isKindOfClass:NSNumber.class]) {
            return [(NSNumber *)aRank compare:(NSNumber *)bRank];
        } else if([aRank isKindOfClass:NSDate.class] && [bRank isKindOfClass:NSDate.class]) {
            return [(NSDate *)aRank compare:(NSDate *)bRank];
        } else if([aRank isKindOfClass:NSIndexPath.class] && [bRank isKindOfClass:NSIndexPath.class]) {
            return [(NSIndexPath *)aRank compare:(NSIndexPath *)bRank];
        }

        return [aRank.description compare:bRank.description];
    };
}

+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath
{
    return [self comparatorForKeyPath:keyPath nilComparison:RESNilComparisonLess];
}

@end
