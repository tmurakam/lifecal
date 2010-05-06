// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.h

#import <UIKit/UIKit.h>

@interface SimpleDate : NSObject {
    int year;
    int month;
    int day;
};

@property (nonatomic,assign) int year;
@property (nonatomic,assign) int month;
@property (nonatomic,assign) int day;

- (id)initWithYear:(int)aYear month:(int)aMonth day:(int)aDay;
- (id)initWithString:(NSString *)str;
- (NSString *)dateString;
- (int)compare:(SimpleDate *)d;

@end
