// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.h

#import <UIKit/UIKit.h>
#import "SimpleDate.h"

@interface Person : NSObject {
    NSString *name;
    SimpleDate *birth;
    SimpleDate *wedding;
    SimpleDate *death;
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) SimpleDate *birth;
@property(nonatomic,retain) SimpleDate *wedding;
@property(nonatomic,retain) SimpleDate *death;

@end
