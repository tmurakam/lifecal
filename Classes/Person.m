// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.m

#import "Person.h"
#import "EventManager.h"

@implementation Person
@synthesize name;

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    [name release];
    for (int i = 0; i < 3; i++) {
        [dates[i] release];
    }
    [super dealloc];
}

- (void)setDate:(SimpleDate *)date type:(int)type
{
    if (dates[type] == date) return;

    [dates[type] release];
    dates[type] = [date retain];
}

- (void)matchEvent:(int)year array:(NSMutableArray *)ary
{
    int yy;
    Event *e;
    EventManager *em = [EventManager sharedInstance];
    NSString *desc;
    int i;

    for (i = 0; i < 3; i++) {
        if (dates[i] == nil) continue;
        
        if (i != EV_DEATH && dates[EV_DEATH] != nil) {
            if (year >= dates[EV_DEATH].year) {
                // すでに死亡している場合は年齢・結婚イベントを出さない
                continue;
            }
        }

        yy = year - dates[i].year;

        e = [em matchEvent:i years:yy];
        if (e) {
            desc = [NSString stringWithFormat:@"%@ : %@", self.name, e.name];
            [ary addObject:desc];
        }
    }
}

@end
