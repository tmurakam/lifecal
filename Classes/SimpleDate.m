// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// SimpleDate.m

#import "SimpleDate.h"

@implementation SimpleDate

@synthesize year, month, day;

- (id)init
{
    self = [super init];
    year = 1900;
    month = 1;
    day = 1;
    
    return self;
}

- (id)initWithYear:(int)aYear month:(int)aMonth day:(int)aDay
{
    self = [super init];
    year = aYear;
    month = aMonth;
    day = aDay;
    return self;
}

// yyyymmdd
- (id)initWithString:(NSString *)str
{
    self = [super init];

    NSRange range;
    range.location = 0;
    range.length = 4;
    year = [[str substringWithRange:range] intValue];
    
    range.location = 4;
    range.length = 2;
    month = [[str substringWithRange:range] intValue];
    
    range.location = 6;
    range.length = 2;
    day = [[str substringWithRange:range] intValue];
    
    return self;
}

- (int)compare:(SimpleDate *)d
{
    if (year != d.year) {
        return year - d.year;
    }
    if (month != d.month) {
        return month - d.month;
    }
    return day - d.day;
}

@end
