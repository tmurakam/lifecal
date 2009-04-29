// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.m

#import "Person.h"

@implementation Person
@synthesize name, birth, wedding, death;

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    [name release];
    [birth release];
    [wedding release];
    [death release];
    [super dealloc];
}

@end
