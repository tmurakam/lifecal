// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// Event.h

#import <UIKit/UIKit.h>

#define EV_AGE      0 // 年齢イベント
#define EV_MARRIAGE 1 // 結婚イベント
#define EV_DEATH    2 // 法要イベント

@interface Event : NSObject {
    int years;  // 経過年
    NSString *name; // イベント名
}

@property(nonatomic, assign) int years;
@property(nonatomic, retain) NSString *name;

@end

