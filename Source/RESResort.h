//
//  RESResort.h
//  
//
//  Created by Florian Ebeling on 18.05.14.
//
//

#import <Foundation/Foundation.h>

@interface RESResort : NSObject

+ (NSComparator)compoundComparatorWithComparatorArray:(NSArray *)comparators;

+ (NSComparator)comparatorForKeyPath:(NSString *)keyPath;

@end
