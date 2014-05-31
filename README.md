# Resort

[![Version](http://cocoapod-badges.herokuapp.com/v/Resort/badge.png)](http://cocoadocs.org/docsets/Resort)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Resort/badge.png)](http://cocoadocs.org/docsets/Resort)

Resort is a small library that builds comparators from key paths,
combines separate comparators into compound ones, and can build
reverse comparators.

### Key Path Comparators

Sorting from a keyPath would be a very straightforward thing to do, if
it weren't for the edge cases. This library deals with nil and NSNull
values and offers special handling of those, like always-less and
always-greater comparison. It uses always-less as a pragmatic
default. But if that's not what you need you can specify that `nil`
should always be treated as greater. Or you might want to fail fast
and throw an exception.

Order is defined for the classes in Foundation that support it already
via `compare:` methods: `NSString`, `NSDate`, `NSNumber`,
`NSIndexPath`, as well as their subclasses, e.g. `NSMutableString` and
`NSDecimalNumber`.

In other cases, the comparator just performs the ordering on the
`-description` of the object.

### Compound Comparators

Comparators build from key paths are very similar to
NSSortDiscriptors, but the have the advantage to be easy to
combine. This is what the other half of the library is about, compound
comparators. Think of it as a simple, composable way to define a sort
order with primary, secondary, and so on sort keys.

## Usage

To run the example project; clone the repo, and run `pod install` from
the Example directory first.

Creation and use of a keyPath comparator looks like this:

```objc
NSComparator comparator = [RESResort comparatorForKeyPath:@"name"];
NSArray *sorted = [@[ z, a ] sortedArrayUsingComparator:comparator];
```

Two comparators (keyPath based or otherwise) can be combined into a
compound comparator and used like this:

```objc
NSComparator nameComparator = [RESResort comparatorForKeyPath:@"name"];
NSComparator countComparator = [RESResort comparatorForKeyPath:@"count"];
NSComparator compoundComparator = [RESResort compoundComparatorWithComparatorArray:@[ nameComparator, countComparator ]];
NSArray *sorted = [_array sortedArrayUsingComparator:compoundComparator];
```

## Requirements

Only Foundation framework. Tested on iOS 7 and OS X 10.9.

## Author

Florian Ebeling, florian.ebeling@gmail.com

## License

Resort is available under the MIT license. See the LICENSE file for
more info.

