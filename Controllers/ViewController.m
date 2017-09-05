//
//  ViewController.m
//  iGel1
//
//  Created by Ian Christie on 7/20/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "ViewController.h"
#import "ArchiveTableViewController.h"
#import "GelObject.h"
#import "EditViewController.h"
#import "About.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Contact Code

- (IBAction)pushedContact:(id)sender {
    Class MailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if(MailClass !=nil) {
		if([MailClass canSendMail]) {
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
            picker.mailComposeDelegate = self;
            NSArray *recipitents = [NSArray arrayWithObject:@"iankchristie@gmail.com"];
            [picker setToRecipients:recipitents];
            [picker setSubject:@"ISSUE"];
            [self presentModalViewController:picker animated:YES];
		}
		else {
			UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Can't Send Mail" 
                                                     message:@"Email Functionality not avaliable on this device" 
                                                     delegate:self cancelButtonTitle:@"Dismiss" 
                                                     otherButtonTitles: nil];
			[error show];
		} 
	}
	else {
		UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Can't Send Mail" 
                                                 message:@"Email Functionality not avaliable on this device" 
                                                 delegate:self cancelButtonTitle:@"Dismiss" 
                                                 otherButtonTitles: nil];
		[error show];
	}
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Camera Code

- (IBAction)pushedCamera:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePicker setDelegate:self];
    [self presentModalViewController:imagePicker animated:YES];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    GelObject *g = [[GelObject alloc]initWithImage:image];
    EditViewController *editor = [[EditViewController alloc]init];
    editor.gel = g;
    [self.navigationController pushViewController:editor animated:NO];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - Button Code

- (IBAction)pushedAbout:(id)sender {
    About *about = [[About alloc] init];
    [self.navigationController pushViewController:about animated:YES];
}

- (IBAction)pushedReferences:(id)sender {
}

-(IBAction)pushedArchive:(id)sender {
    //Alert View
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Loading Data"
                                                        message:@"\n"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];   
    spinner.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
    [alertView addSubview:spinner];
    [spinner startAnimating];
    [alertView show];
    
    ArchiveTableViewController *archive = [[ArchiveTableViewController alloc]init];
    [self.navigationController pushViewController:archive animated:YES];
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - Default Code

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1984_pfgel1.jpeg"]]];
}

- (void)viewDidUnload {
    //[self setLogo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
