//
//  RESResort.h
//
//
//  Created by Florian Ebeling on 18.05.14.
//
//

#import <Foundation/Foundation.h>

///--------------------
/// @name Constants
///--------------------

typedef NS_ENUM(NSUInteger, RESNilComparison) {
    RESNilComparisonThrows,
    RESNilComparisonLess,
    RESNilComparisonMore
};

extern NSString * const RESErrorDomain;

/**
   Package containing a number of class methods for creating and
   combining comparators.

   @see NSComparator
 */
@interface RESResort : NSObject

///---------------------
/// @name Transformation
///---------------------

/**
   Create a comparator with reverse sort order of the one passed in.

   The method creates a comparator that produces the reverse sort
   order as the comparator passed in.

   @param the base comparator
   @return the reversed comparator
 */
+ (NSComparator)reverseComparator:(NSComparator)comparator;

///------------------
/// @name Combination
///------------------

/**
   Create a compound comparator from the comparators passed as array.

   A compound comparator sorts by applying several comparators in
   order. If the first one finds an order, only that is
   used. Otherwise, the second comparator is applied and returned, and
   so on. This way existing comparators can be easily combined and
   used to specify sorting with primary, secondary, and so on
   ordering.

   Order of the comparators in the array is important.

   @param comparators array of comparators to combine into a compound
   comparator, applied in the order passed in.

   @return the compound comparator
 */
+ (NSComparator)compoundComparatorWithComparatorArray:(NSArray *)comparators;

///---------------
/// @name Creation
///---------------

/**
   Create comparator for specific key path.

   The comparator orders objects by using the specified key path. The
   values to compare are determined by calling `-valueForKeyPath:` on
   the objects to establish an order for.

   Ordering itself uses `-compare:`, if it is defined. That is
   NSString, NSDate, NSNumber and NSIndexPath for Foundation. On your
   own class definitions you can implement more specific sort
   orders. Most of the time relaying to one of the built-in ones makes
   a lot of sense, though.

   If the object doesn't implement the `-compare:` method, the
   comparator will fall back to sort on the description string of the
   value.

   Sort order for `nil` values is usually undefined. For practical
   purposes it's often useful to have more control. You can specify
   `nil` always is considered less by passing `RESNilComparisonLess`,
   or that it's always considered more by passing
   `RESNilComparisonMore`, to have them at the top or the bottom of
   e.g. a list in the UI. Specify `RESNilComparisonThrows` to raise in
   exception in that case.

   Compound comparators can be used instead of standard
   `NSSortDescriptor` instances, which afford similar
   functionality. Comparators use closures (implemented as blocks) for
   their task. Some people prefer that since closures offer better
   encapsulation and composability. Be aware of this alternative,
   though.

   @param keyPath the keyPath to used to get a sort value
   @param nilComparison how to handle `nil` values in comparisons

   @return the comparator
   @see comparatorForKeyPath:
   @see NSSortDescriptor
   @see sortedArrayUsingDescriptors:
   @see sortedArrayUsingSelector:
 */
+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath nilComparison:(RESNilComparison)nilComparison;

/**
   Create comparator for specific key path, assuming `nil` ranks less
   than any value.

   This creates a comparator as described for
   `comparatorForKeyPath:nilComparison:` when passing
   `RESNilComparisonLess` for `nilComparison:`

   @return the comparator
   @see comparatorForKeyPath:nilComparison:
*/
+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath;

@end
