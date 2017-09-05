//
//  ArchiveTableViewController.m
//  iGel1
//
//  Created by Ian Christie on 7/25/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "ArchiveTableViewController.h"
#import "AppDelegate.h"
#import "GelObject.h"
#import "DisplayDataViewController.h"

@interface ArchiveTableViewController ()

@end

@implementation ArchiveTableViewController

@synthesize gelData;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: [AppDelegate getDataFilePath]]) {
        gelData = [NSKeyedUnarchiver unarchiveObjectWithFile: [AppDelegate getDataFilePath]];
    }
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Archive";
}

- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"unloaded");
    [NSKeyedArchiver archiveRootObject: gelData toFile:[AppDelegate getDataFilePath]];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [gelData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    GelObject *g = [gelData objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    } 
    cell.textLabel.text = g.name;
    cell.detailTextLabel.text = g.dateString;
    cell.imageView.image = g.original;    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *temp;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [gelData removeObjectAtIndex:indexPath.row];
        temp = gelData;
        [NSKeyedArchiver archiveRootObject: temp toFile:[AppDelegate getDataFilePath]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
 
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GelObject *g = [gelData objectAtIndex:indexPath.row];
    // Navigation logic may go here. Create and push another view controller.
    DisplayDataViewController *detailViewController = [[DisplayDataViewController alloc] init];
    detailViewController.gelObject = g;
    detailViewController.from = NO;
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
