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

#define EV(y, n) [Event addEvent:ary year:y name:n]

    switch (type) {
    case EV_AGE: // すべて数え年齢
        EV(61, @"還暦");
        EV(70, @"古稀");
        EV(77, @"喜寿");
        EV(80, @"傘寿");
        EV(88, @"米寿");
        EV(90, @"卆寿");
        EV(99, @"白寿");
        EV(100, @"百寿");
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
        EV(2, @"三回忌");
        EV(6, @"七回忌");
        EV(12, @"十三回忌");
        EV(16, @"十七回忌");
        EV(22, @"二十三回忌");
        EV(26, @"二十七回忌");
        EV(32, @"三十三回忌");
        EV(49, @"五十回忌");
        break;
    }

    return ary;
}

+ (void)_addEvent:(NSMutableArray*)ary year:(int)year name:(NSString *)name
{
    Event *ev = [[Event alloc] init];
    ev.year = year;
    ev.name = name;
    [ary addObject:ev];
    [ev release];
}

@end

