//
//  iOS_TestsTests.m
//  iOS TestsTests
//
//  Created by Florian Ebeling on 18.05.14.
//
//

#import <XCTest/XCTest.h>
#import "NSArray+Shuffle.h"

#import "RESResort.h"

@interface Item : NSObject
@property NSString *name;
@property NSInteger count;
@property NSDate *date;
@property NSIndexPath *indexPath;
@end

@implementation Item
@end

@interface Container : NSObject
@property Item *item;
@end

@implementation Container
@end

@interface KeyPathComparatorTest : XCTestCase
@property NSArray *unsorted;
@property Container *a;
@property Container *b;
@property Container *c;
@end

@implementation KeyPathComparatorTest

- (void)setUp
{
    [super setUp];

    _a = [[Container alloc] init];
    _a.item = [[Item alloc] init];
    _a.item.name = @"Aaron";
    _a.item.date = NSDate.date;
    _a.item.count = 1;

    _b = [[Container alloc] init];
    _b.item = [[Item alloc] init];
    _b.item.name = @"Ben";
    _b.item.date = [NSDate dateWithTimeIntervalSinceNow:1000];
    _b.item.count = 2;

    _c = [[Container alloc] init];
    _c.item = [[Item alloc] init];
    _c.item.name = @"Zero";
    _c.item.date = [NSDate dateWithTimeIntervalSinceNow:-1000];
    _c.item.count = 3;

    _unsorted = [@[ _a, _b, _c ] shuffledArray];
}

- (void)testKeyPathSorting
{
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.name"];

    NSArray *sorted = [_unsorted sortedArrayUsingComparator:comparator];

    expect(sorted).to.equal(@[ _a, _b, _c ]);
}

- (void)testKeyPathSorting_Dictionaries
{
    NSDictionary *a = @{ @"name": @"Aaron" };
    NSDictionary *z = @{ @"name": @"Zero" };

    NSComparator comparator = [RESResort comparatorForKeyPath:@"name"];
    NSArray *sorted = [@[ z, a ] sortedArrayUsingComparator:comparator];

    expect(sorted).to.equal(@[ a, z ]);
}

#pragma mark Nil Handling

- (void)testKeyPathSorting_NilIsLessByDefault
{
    _b.item.name = nil;
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.name"];

    NSArray *sorted = [_unsorted sortedArrayUsingComparator:comparator];

    expect(sorted.firstObject).to.equal(_b);
}

- (void)testKeyPathSorting_NilIsLess
{
    _b.item.name = nil;
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.name"
                               nilComparison:RESNilComparisonLess];

    NSArray *sorted = [_unsorted sortedArrayUsingComparator:comparator];

    expect(sorted.firstObject).to.equal(_b);
}

- (void)testKeyPathSorting_NilIsMore
{
    _b.item.name = nil;
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.name"
                                                    nilComparison:RESNilComparisonMore];

    NSArray *sorted = [_unsorted sortedArrayUsingComparator:comparator];

    expect(sorted).to.equal(@[ _a, _c, _b ]);
    expect(sorted.lastObject).to.beIdenticalTo(_b);
}

- (void)testKeyPathSorting_Raises
{
    _b.item.name = nil;
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.name"
                                                    nilComparison:RESNilComparisonThrows];

    expect(^{
        [_unsorted sortedArrayUsingComparator:comparator];
    }).to.raise(@"Nil comparison");
}

- (void)testKeyPathSorting_Date
{
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.date"];

    NSArray *sorted = [_unsorted sortedArrayUsingComparator:comparator];

    expect(sorted).to.equal(@[ _c, _a, _b ]);
}

- (void)testKeyPathSorting_Count
{
    NSComparator comparator = [RESResort comparatorForKeyPath:@"item.count"];

    NSArray *sorted = [_unsorted sortedArrayUsingComparator:comparator];

    expect(sorted).to.equal(@[ _a, _b, _c ]);
}

@end
