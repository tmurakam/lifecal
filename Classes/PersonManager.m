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

#if 0
    [Person delete_all];
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

        // reload
        persons = [Person find_all];
    }
#endif
    
    [self reload];

    return self;
}

- (void)reload
{
    [persons release];
    persons = [[Person find_all] retain];
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
        int yy, birth_year = -1, marriage_year = -1, death_year = -1;
        Event *e;
        NSDateComponents *comp;
        
        if (person.birth_date != nil) {
            comp = [greg components:NSYearCalendarUnit fromDate:person.birth_date];
            birth_year = [comp year];
        }
        if (person.marriage_date != nil) {
            comp = [greg components:NSYearCalendarUnit fromDate:person.marriage_date];
            marriage_year = [comp year];
        }
        if (person.death_date != nil) {
            comp = [greg components:NSYearCalendarUnit fromDate:person.death_date];
            death_year = [comp year];
        }
        
        //NSLog(@"%d %d %d", birth_year, marriage_year, death_year);
        
        if (death_year < 0 || year <= death_year) {
            // 年齢
            if (birth_year > 0) {
                yy = year - birth_year; 
                e = [em matchEvent:EV_AGE years:yy];
                if (e) {
                    [ary addObject:[NSString stringWithFormat:@"%@ : %@", person.name, e.name]];
                }
            }
            
            // 結婚
            if (marriage_year > 0) {
                yy = year - marriage_year;
                e = [em matchEvent:EV_MARRIAGE years:yy];
                if (e) {
                    [ary addObject:[NSString stringWithFormat:@"%@ : %@", person.name, e.name]];
                }
            }
        }

        // 死亡
        if (death_year > 0) {
            yy = year - death_year;
            e = [em matchEvent:EV_DEATH years:yy];
            if (e) {
                [ary addObject:[NSString stringWithFormat:@"%@ : %@", person.name, e.name]];
            }
        }
    }
    return ary;
}

@end
