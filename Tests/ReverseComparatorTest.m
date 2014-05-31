//
//  ReverseComparator.m
//  Resort Tests
//
//  Created by Florian Ebeling on 31.05.14.
//
//

#import <XCTest/XCTest.h>
#import "RESResort.h"

#import "NSArray+Shuffle.h"

@interface ReverseComparatorTest : XCTestCase
@property NSDictionary *a;
@property NSDictionary *b;
@property NSDictionary *z;
@property NSArray *array;
@end

@implementation ReverseComparatorTest

- (void)setUp
{
    [super setUp];
    _a = @{ @"name": @"Aaron" };
    _b = @{ @"name": @"Ben" };
    _z = @{ @"name": @"Zero" };

    _array = [@[ _a, _b, _z ] shuffledArray];
}

- (void)testReverseComparator
{
    NSComparator nameComparator = [RESResort comparatorForKeyPath:@"name"];
    NSComparator reverseComparator = [RESResort reverseComparator:nameComparator];

    NSArray *sorted = [_array sortedArrayUsingComparator:reverseComparator];

    expect(sorted).to.equal(@[ _z, _b, _a ]);
}

@end
