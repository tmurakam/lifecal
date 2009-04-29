// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.h

#import <UIKit/UIKit.h>
#import "SimpleDate.h"

@interface Person : NSObject {
    NSString *name;
    SimpleDate *dates[3];
}

@property(nonatomic,retain) NSString *name;

- (void)setDate:(SimpleDate *)date type:(int)type;
- (void)matchEvent:(int)year array:(NSMutableArray *)ary;

@end
