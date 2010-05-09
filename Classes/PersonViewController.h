//
//  PersonViewController.h
//  lifecal
//
//  Created by 村上 卓弥 on 10/05/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "GenEditTextViewController.h"
#import "EditDateViewController.h"

@interface PersonViewController : UITableViewController <GenEditTextViewDelegate, EditDateViewDelegate> {
    Person *person;
    
    int currentEditingRow;
}

@property(nonatomic,retain) Person *person;

@end
