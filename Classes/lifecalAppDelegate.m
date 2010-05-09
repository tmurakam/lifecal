// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-
//
//  lifecalAppDelegate.m
//  lifecal
//
//  Created by 村上 卓弥 on 09/04/29.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "lifecalAppDelegate.h"
#import "Database.h"
#import "Person.h"

@implementation lifecalAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Initialize database
    Database *db = [Database instance];
    [db open:@"lifecal.db"];
    
    // migrate tables
    [Person migrate];
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

