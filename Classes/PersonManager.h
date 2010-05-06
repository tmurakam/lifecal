// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// PersonManager

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PersonManager : NSObject {
    NSMutableArray *persons;
}

+ (PersonManager *)sharedInstance;
- (NSMutableArray *)matchEvent:(int)year;

- (int)count;
- (Person *)objectAtIndex:(int)idx;

@end

