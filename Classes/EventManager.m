// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// EventManager

#import "EventManager.h"

@implementation EventManager

+ (EventManager *)sharedInstance
{
    static EventManager *theManager = nil;

    if (theManager == nil) {
        theManager = [[EventManager alloc] init];
    }
    return theManager;
}

- (id)init
{
    self = [super init];

    for (int i = 0; i < 3; i++) {
        events[i] = [[NSMutableArray alloc] init];
    }
    
    // 年齢イベント
    // 年齢はすべて数え年なので注意
    [self addEvent:EV_AGE year:61 name:@"還暦"];
    [self addEvent:EV_AGE year:70 name:@"古希"];
    [self addEvent:EV_AGE year:77 name:@"喜寿"];
    [self addEvent:EV_AGE year:88 name:@"米寿"];
    [self addEvent:EV_AGE year:99 name:@"白寿"];
    [self addEvent:EV_AGE year:120 name:@"大還暦"];

    // 結婚イベント
    [self addEvent:EV_MARRIAGE year:25 name:@"銀婚式"];
    [self addEvent:EV_MARRIAGE year:50 name:@"金婚式"];
    [self addEvent:EV_MARRIAGE year:55 name:@"エメラルド婚式"];
    [self addEvent:EV_MARRIAGE year:60 name:@"ダイヤモンド婚式"];
    [self addEvent:EV_MARRIAGE year:75 name:@"プラチナ婚式"];

    // 法要イベント
    [self addEvent:EV_DEATH year:1 name:@"一回忌"];
    [self addEvent:EV_DEATH year:2 name:@"三回忌"];
    [self addEvent:EV_DEATH year:6 name:@"七回忌"];
    [self addEvent:EV_DEATH year:12 name:@"十三回忌"];
    [self addEvent:EV_DEATH year:16 name:@"十七回忌"];
    [self addEvent:EV_DEATH year:22 name:@"二十三回忌"];
    [self addEvent:EV_DEATH year:26 name:@"二十七回忌"];
    [self addEvent:EV_DEATH year:32 name:@"三十三回忌"];
    [self addEvent:EV_DEATH year:49 name:@"五十回忌"];

    return self;
}

- (void)addEvent:(int)type year:(int)year name:(NSString *)name
{
    Event *ev = [[[Event alloc] init] autorelease];
    ev.years = year;
    ev.name = name;

    [events[type] addObject:ev];
}


@end
