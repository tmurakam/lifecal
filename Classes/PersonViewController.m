//
//  PersonViewController.m
//  lifecal
//
//  Created by 村上 卓弥 on 10/05/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonManager.h"

#import "GenEditTextViewController.h"
#import "EditDateViewController.h"

@implementation PersonViewController

@synthesize person;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self action:@selector(savePerson)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDate *date = nil;

    cell.detailTextLabel.text = @"";
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"名前";
            cell.detailTextLabel.text = person.name;
            break;
            
        case 1:
            cell.textLabel.text = @"生年月日";
            date = person.birth_date;
            break;
            
        case 2:
            cell.textLabel.text = @"結婚日";
            date = person.marriage_date;
            break;
            
        case 3:
            cell.textLabel.text = @"死亡日";
            date = person.death_date;
            break;
    }

    if (date != nil) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        //[dateFormatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat: @"yyyy/MM/dd"];
        
        cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    }

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDate *date;
    GenEditTextViewController *editTextVc;
    
    switch (indexPath.row) {
        case 0:
            editTextVc = [GenEditTextViewController genEditTextViewController:self title:@"名前" identifier:0];
            editTextVc.text = person.name;
            [self.navigationController pushViewController:editTextVc animated:YES];
            return;
            
        case 1:
            date = person.birth_date;
            break;
            
        case 2:
            date = person.marriage_date;
            break;
            
        case 3:
            date = person.death_date;
            break;
    }
    
    if (indexPath.row >= 1) {
        currentEditingRow = indexPath.row;
        
        EditDateViewController *vc = [[EditDateViewController alloc] initWithNibName:@"EditDateView" bundle:nil];
        vc.date = date;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

#pragma mark -
#pragma mark Event handling
- (void)savePerson
{
    [person save];
    
    [[PersonManager sharedInstance] reload];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)genEditTextViewChanged:(GenEditTextViewController *)vc identifier:(int)id
{
    person.name = vc.text;
    [self.tableView reloadData];
}

- (void)editDateViewChanged:(EditDateViewController *)vc
{
    NSDate *date = vc.date;
    
    switch (currentEditingRow) {
        case 1:
            person.birth_date = date;
            break;
        case 2:
            person.marriage_date = date;
            break;
        case 3:
            person.death_date = date;
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

