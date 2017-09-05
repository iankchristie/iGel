//
//  EditViewController.m
//  iGel1
//
//  Created by Ian Christie on 7/21/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "EditViewController.h"
#import "AppDelegate.h"
#import "GelObject.h"
#import "FilterViewController.h"
#import "DisplayDataViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

@synthesize gel;

//view stuff
@synthesize imageView;
@synthesize dateLabel;
@synthesize saveButton;
@synthesize tV;
@synthesize textField;

-(IBAction)nameEntered:(id)sender {
    UITextField *tf = (UITextField *) sender;
    self.gel.name = tf.text;
    [tf resignFirstResponder];
    self.saveButton.hidden=NO;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        self.gel.description = textView.text;
        return FALSE;
    }
    return TRUE;
}

-(IBAction)pushedSaved:(id)sender {
    //Alert View
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Saving Data"
                                           message:@"\n"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];   
    spinner.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
    [alertView addSubview:spinner];
    [spinner startAnimating];
    [alertView show];
    
    //File Mananagin
    NSFileManager *filemgr = [NSFileManager defaultManager];;
    NSMutableArray *gData;

    if ([filemgr fileExistsAtPath: [AppDelegate getDataFilePath]]) {
        gData = [NSKeyedUnarchiver unarchiveObjectWithFile: [AppDelegate getDataFilePath]];
    }
    [gData addObject:gel];
    [NSKeyedArchiver archiveRootObject: gData toFile:[AppDelegate getDataFilePath]];
    
    //Loading Next View
    DisplayDataViewController *dd = [[DisplayDataViewController alloc]init];
    dd.gelObject = gel;
    dd.from = YES;
    
    //Ending loading View
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
    //pushing nextview
    [self.navigationController pushViewController:dd animated:YES];
}

#pragma mark - Filter Stuff

-(IBAction)pushedFilter:(id)sender {
    FilterViewController *filterViewController = [[FilterViewController alloc]init];
    filterViewController.image = gel.original;
    filterViewController.delegate = self;
    [self.navigationController pushViewController:filterViewController animated:YES];
}

-(void)save:(UIImage *)filteredImage {
    [gel.pictures addObject:filteredImage];
}

#pragma mark - Email Code

-(IBAction)sendPhoto {
    Class MailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if(MailClass !=nil)
	{
		if([MailClass canSendMail])
		{
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
            picker.mailComposeDelegate = self;
            NSArray *recipitents = [NSArray arrayWithObject:@"abc@xyz.com"];
            [picker setToRecipients:recipitents];
            [picker setSubject:@"Picture"];
            NSData *imageData = UIImagePNGRepresentation(gel.original);
            [picker addAttachmentData:imageData mimeType:@"image/png" fileName:@"iGelPicture"]; 
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
                                                       message:@"Error in opening Framework" 
                                                      delegate:self cancelButtonTitle:@"Dismiss" 
                                             otherButtonTitles: nil];
		[error show];
	}
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark - Constructors

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //appearance
    self.navigationItem.title = @"Edit";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Send Photo" style:UIBarButtonItemStyleBordered target:self action:@selector(sendPhoto)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    //date
    self.gel.date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    self.gel.dateString = [dateFormat stringFromDate:self.gel.date];
    self.dateLabel.text = self.gel.dateString;
    //button stuff
    self.imageView.image = self.gel.original;
    saveButton.hidden=YES;
    tV.editable=YES;
    tV.delegate=self;
    if(gel.name) {
        textField.text = gel.name;
    }
    else {
        textField.placeholder = @"Name";
    }
    if (gel.description) {
        tV.text = gel.description;
    }
    else {
        tV.text = @"Description";
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
