//
//  EditDateViewController.h
//  lifecal
//
//  Created by 村上 卓弥 on 10/05/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditDateViewController;

@protocol EditDateViewDelegate
- (void)editDateViewChanged:(EditDateViewController *)vc;
@end

@interface EditDateViewController : UIViewController {
    IBOutlet UIDatePicker *datePicker;
    
    id<EditDateViewDelegate> delegate;
    NSDate *date;
}

@property(nonatomic,assign) id<EditDateViewDelegate> delegate;
@property(nonatomic,retain) NSDate *date;

- (IBAction)removeDateButtonTapped:(id)sender;

@end
