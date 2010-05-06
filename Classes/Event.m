// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// event.m

#import "Event.h"

@implementation Event

@synthesize years, name;

static NSMutableArray *events[3];

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

+ (NSArray *)getEventArray:(int)type
{
    if (events[type] != nil) {
        return events[type];
    }

    NSMutableArray *ary = [[NSMutableArray alloc] init];
    events[type] = ary;

#define EV(y, n) [Event _addEvent:ary year:(y) name:(n)]

    switch (type) {
    case EV_AGE: // すべて満年齢
        EV(60, @"還暦");
        EV(70-1, @"古稀");
        EV(77-1, @"喜寿");
        EV(80-1, @"傘寿");
        EV(88-1, @"米寿");
        EV(90-1, @"卆寿");
        EV(99-1, @"白寿");
        EV(100-1, @"百寿");
        break;

    case EV_MARRIAGE:
        EV(25, @"銀婚式");
        EV(30, @"真珠婚式");
        EV(35, @"珊瑚婚式");
        EV(40, @"ルビー婚式");
        EV(45, @"サファイア婚式");
        EV(50, @"金婚式");
        EV(55, @"エメラルド婚式");
        EV(60, @"ダイヤモンド婚式");
        EV(75, @"プラチナ婚式");
        break;

    case EV_DEATH:
        EV(1, @"一周忌");
        EV(3-1, @"三回忌");
        EV(7-1, @"七回忌");
        EV(13-1, @"十三回忌");
        EV(17-1, @"十七回忌");
        EV(23-1, @"二十三回忌");
        EV(27-1, @"二十七回忌");
        EV(33-1, @"三十三回忌");
        EV(50-1, @"五十回忌");
        break;
    }

    return ary;
}

+ (void)_addEvent:(NSMutableArray*)ary year:(int)years name:(NSString *)name
{
    Event *ev = [[Event alloc] init];
    ev.years = years;
    ev.name = name;
    [ary addObject:ev];
    [ev release];
}

@end

