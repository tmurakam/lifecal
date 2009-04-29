// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-
//
//  YearListViewController.h
//  lifecal
//
//  Created by 村上 卓弥 on 09/04/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YearListViewController : UITableViewController {
    int firstYear;
    NSMutableArray *sectionTitles;
}

@end
