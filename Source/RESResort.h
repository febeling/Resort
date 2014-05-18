//
//  RESResort.h
//  
//
//  Created by Florian Ebeling on 18.05.14.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RESNilComparison) {
    RESNilComparisonThrows,
    RESNilComparisonLess,
    RESNilComparisonMore
};

extern NSString * const RESErrorDomain;

@interface RESResort : NSObject

+ (NSComparator)compoundComparatorWithComparatorArray:(NSArray *)comparators;

+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath nilComparison:(RESNilComparison)nilComparison;

+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath;

@end
