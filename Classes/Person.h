// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.h

#import <UIKit/UIKit.h>
#import "Database.h"
#import "SimpleDate.h"


@interface Person : NSObject {
    int pkey; // primary id
    NSString *name;
    SimpleDate *dates[3];
}

@property(nonatomic,assign) int pkey;
@property(nonatomic,retain) NSString *name;

- (void)setDate:(SimpleDate *)date type:(int)type;
- (void)matchEvent:(int)year array:(NSMutableArray *)ary;

+ (void)checkTable;
+ (dbstmt *)selectAll;
- (void)loadRow:(dbstmt *)stmt;
- (void)insert;
- (void)update;
- (void)delete;

@end
