// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// EventManager

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventManager : NSObject {
    NSMutableArray *events[3];
}

+ (EventManager *)sharedInstance;
- (void)addEvent:(int)type year:(int)year name:(NSString *)name;
- (Event *)matchEvent:(int)type years:(int)yy;

@end

