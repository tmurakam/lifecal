//
//  PersonViewController.h
//  lifecal
//
//  Created by 村上 卓弥 on 10/05/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PersonViewController : UITableViewController {
    Person *person;
}

@property(nonatomic,retain) Person *person;

@end
