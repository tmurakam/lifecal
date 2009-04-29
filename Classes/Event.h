// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.h

@interface Event : NSObject {
    int years;  // 経過年
    NSString *name; // イベント名
}

@property(nonatomic, assign) int years;
@property(nonatomic, retain) NSString *name;

@end

