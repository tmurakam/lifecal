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
    [self addEvent:EV_AGE year:60 name:@"還暦"];
    [self addEvent:EV_AGE year:70-1 name:@"古希"];
    [self addEvent:EV_AGE year:77-1 name:@"喜寿"];
    [self addEvent:EV_AGE year:88-1 name:@"米寿"];
    [self addEvent:EV_AGE year:99-1 name:@"白寿"];
    [self addEvent:EV_AGE year:120 name:@"大還暦"];

    // 結婚イベント
    [self addEvent:EV_MARRIAGE year:25 name:@"銀婚式"];
    [self addEvent:EV_MARRIAGE year:30 name:@"真珠婚式"];
    [self addEvent:EV_MARRIAGE year:35 name:@"珊瑚婚式"];
    [self addEvent:EV_MARRIAGE year:40 name:@"ルビー婚式"];
    [self addEvent:EV_MARRIAGE year:40 name:@"サファイア婚式"];
    [self addEvent:EV_MARRIAGE year:50 name:@"金婚式"];
    [self addEvent:EV_MARRIAGE year:55 name:@"エメラルド婚式"];
    [self addEvent:EV_MARRIAGE year:60 name:@"ダイヤモンド婚式"];
    [self addEvent:EV_MARRIAGE year:75 name:@"プラチナ婚式"];

    // 法要イベント
    [self addEvent:EV_DEATH year:1 name:@"一回忌"];
    [self addEvent:EV_DEATH year:3-1 name:@"三回忌"];
    [self addEvent:EV_DEATH year:7-1 name:@"七回忌"];
    [self addEvent:EV_DEATH year:13-1 name:@"十三回忌"];
    [self addEvent:EV_DEATH year:17-1 name:@"十七回忌"];
    [self addEvent:EV_DEATH year:23-1 name:@"二十三回忌"];
    [self addEvent:EV_DEATH year:27-1 name:@"二十七回忌"];
    [self addEvent:EV_DEATH year:33-1 name:@"三十三回忌"];
    [self addEvent:EV_DEATH year:50-1 name:@"五十回忌"];

    return self;
}

- (void)addEvent:(int)type year:(int)year name:(NSString *)name
{
    Event *ev = [[[Event alloc] init] autorelease];
    ev.years = year;
    ev.name = name;

    [events[type] addObject:ev];
}

- (Event *)matchEvent:(int)type years:(int)yy
{
    for (Event *ev in events[type]) {
        if (ev.years == yy) {
            return ev;
        }
    }
    return nil;
}

@end
