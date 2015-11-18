//
//  NSNumber+Math.m
//  Cocoahead
//
//  Created by Ikmal Ezzani on 11/13/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#import "NSNumber+Math.h"

@implementation NSNumber (Math)
- (NSNumber *)plus:(NSNumber *)number
{
    return @([self integerValue] + [number integerValue]);
}

- (NSNumber *)minus:(NSNumber *)number
{
    return @([self integerValue] - [number integerValue]);
}

- (NSNumber *)divide:(NSNumber *)number
{
    return @([self integerValue] / [number integerValue]);
}

- (NSNumber *)multiply:(NSNumber *)number
{
    return @([self integerValue] * [number integerValue]);
}
@end
