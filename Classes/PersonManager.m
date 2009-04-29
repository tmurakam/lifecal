// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// PersonManager

#import "PersonManager.h"

@implementation PersonManager

+ (PersonManager *)sharedInstance
{
    static PersonManager *theManager = nil;

    if (theManager == nil) {
        theManager = [[PersonManager alloc] init];
    }
    return theManager;
}

- (id)init
{
    self = [super init];

    persons = [[NSMutableArray alloc] init];

    // test data
    Person *p = [[[Person alloc] init] autorelease];
    p.name = @"テストユーザ";
    p.birth = [[[SimpleDate alloc] initWithYear:1970 month:1 day:1] autorelease];
    p.wedding = [[[SimpleDate alloc] initWithYear:2000 month:1 day:1] autorelease];

    [persons addObject:p];

    return self;
}


@end
