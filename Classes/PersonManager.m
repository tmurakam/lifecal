// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// PersonManager

#import <UIKit/UIKit.h>

#import "PersonManager.h"
#import "Person.h"
#import "EventManager.h"

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

    persons = [Person find_all];

    if ([persons count] == 0) {
        Person *p;
        NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
        NSCalendar *cal = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        
        // test data
        p = [[Person alloc] init];
        p.name = @"TM";
        p.register_date = [NSDate date];
        comps.year = 1970; comps.month = 12; comps.day = 23;
        p.birth_date = [cal dateFromComponents:comps];
        comps.year = 2005; comps.month = 1; comps.day = 1;
        p.marriage_date = [cal dateFromComponents:comps];
        [p save];
        [p release];

        p = [[Person alloc] init];
        p.name = @"KM";
        p.register_date = [NSDate date];
        comps.year = 1944; comps.month = 2; comps.day = 20;
        p.birth_date = [cal dateFromComponents:comps];
        comps.year = 1970; comps.month = 4; comps.day = 1;
        p.marriage_date = [cal dateFromComponents:comps];
        comps.year = 1990; comps.month = 10; comps.day = 1;
        p.death_date = [cal dateFromComponents:comps];
        [p save];
        [p release];            

        persons = [Person find_all];
    }

    return self;
}

- (int)count
{
    return [persons count];
}

- (Person *)objectAtIndex:(int)idx
{
    return [persons objectAtIndex:idx];
}

// 全員分のイベントを収集する
- (NSMutableArray *)matchEvent:(int)year
{
    NSMutableArray *ary = [[[NSMutableArray alloc] init] autorelease];
    EventManager *em = [EventManager sharedInstance];
    
    NSCalendar *greg = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    for (Person *person in persons) {
        int yy;
        Event *e;

        NSDateComponents *birth = [greg components:NSYearCalendarUnit fromDate:person.birth_date];
        NSDateComponents *marriage = [greg components:NSYearCalendarUnit fromDate:person.marriage_date];
        NSDateComponents *death = [greg components:NSYearCalendarUnit fromDate:person.death_date];
        
        if (year < death.year) {
            // 年齢
            yy = year - birth.year; 
            e = [em matchEvent:EV_AGE years:yy];
            if (e) {
                [ary addObject:[NSString stringWithFormat:@"%@ : %@", person.name, e.name]];
            }
            
            // 結婚
            yy = year - marriage.year;
            e = [em matchEvent:EV_MARRIAGE years:yy];
            if (e) {
                [ary addObject:[NSString stringWithFormat:@"%@ : %@", person.name, e.name]];
            }
        }

        // 死亡
        yy = year - death.year;
        e = [em matchEvent:EV_DEATH years:yy];
        if (e) {
            [ary addObject:[NSString stringWithFormat:@"%@ : %@", person.name, e.name]];
        }
    }
    return ary;
}

@end
