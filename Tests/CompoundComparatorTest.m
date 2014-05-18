//
//  CompoundComparatorTest.m
//  Resort Tests
//
//  Created by Florian Ebeling on 18.05.14.
//

#import <XCTest/XCTest.h>
#import "RESResort.h"

#import "NSArray+Shuffle.h"

@interface CompoundComparatorTest : XCTestCase
@property NSDictionary *a;
@property NSDictionary *b;
@property NSDictionary *z;
@property NSArray *array;
@end

@implementation CompoundComparatorTest

- (void)setUp
{
    [super setUp];

    _a = @{ @"name": @"Aaron", @"count": @1 };
    _b = @{ @"name": @"Ben",   @"count": @2 };
    _z = @{ @"name": @"Aaron", @"count": @3 };

    _array = [@[ _a, _b, _z ] shuffledArray];
}

- (void)testKeyPathSorting_NameAndCount
{
    NSComparator nameComparator = [RESResort comparatorForKeyPath:@"name"];
    NSComparator countComparator = [RESResort comparatorForKeyPath:@"count"];
    NSComparator compoundComparator = [RESResort compoundComparatorWithComparatorArray:@[ nameComparator, countComparator ]];
    NSArray *sorted = [_array sortedArrayUsingComparator:compoundComparator];

    expect(sorted).to.equal(@[ _a, _z, _b ]);
}

- (void)testKeyPathSorting_CountAndName
{
    NSComparator nameComparator = [RESResort comparatorForKeyPath:@"name"];
    NSComparator countComparator = [RESResort comparatorForKeyPath:@"count"];
    NSComparator compoundComparator = [RESResort compoundComparatorWithComparatorArray:@[ countComparator, nameComparator ]];
    NSArray *sorted = [_array sortedArrayUsingComparator:compoundComparator];

    expect(sorted).to.equal(@[ _a, _b, _z ]);
}

@end
