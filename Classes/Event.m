// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// event.m

#import "Event.h"

@implementation Event

@synthesize years, name;

- (id)init
{
    self = [super init];

    return self;
}

- (void)dealloc
{
    [name release];
    [super dealloc];
}

@end

