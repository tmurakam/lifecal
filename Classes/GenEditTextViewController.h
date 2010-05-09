// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

#import <UIKit/UIKit.h>

@class GenEditTextViewController;

@protocol GenEditTextViewDelegate
- (void)genEditTextViewChanged:(GenEditTextViewController *)vc identifier:(int)id;
@end

@interface GenEditTextViewController : UIViewController {
    IBOutlet UITextField *textField;
	
    id<GenEditTextViewDelegate> delegate;
    NSString *text;
    int identifier;
}

@property(nonatomic,assign) id<GenEditTextViewDelegate> delegate;
@property(nonatomic,assign) int identifier;
@property(nonatomic,retain) NSString *text;

+ (GenEditTextViewController *)genEditTextViewController:(id<GenEditTextViewDelegate>)delegate title:(NSString*)title identifier:(int)id;
- (void)doneAction;

@end
