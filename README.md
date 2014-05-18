# Resort

[![Version](http://cocoapod-badges.herokuapp.com/v/Resort/badge.png)](http://cocoadocs.org/docsets/Resort)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Resort/badge.png)](http://cocoadocs.org/docsets/Resort)

Resort is a small library that builds comparators from key paths and
combines separate comparators into compound comparators.

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

## Usage

To run the example project; clone the repo, and run `pod install` from
the Example directory first.

## Requirements

Only Foundation framework. Tested on iOS 7 and OS X 10.9.

## Author

Florian Ebeling, florian.ebeling@gmail.com

## License

Resort is available under the MIT license. See the LICENSE file for
more info.

