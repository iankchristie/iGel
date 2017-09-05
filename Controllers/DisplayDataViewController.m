//
//  DisplayDataViewController
//  iGel1
//
//  Created by Ian Christie on 7/25/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "DisplayDataViewController.h"
#import "GelObject.h"
#import "EditViewController.h"

@interface DisplayDataViewController ()

@end

@implementation DisplayDataViewController

@synthesize gelObject;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize descriptionView;
@synthesize largeScrollView;
@synthesize imageView;
@synthesize ladderImageView;
@synthesize arrayScrollView;
@synthesize from;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    int x = 5;
    int y = 5;
    int height = 50;
    int width = 50;
    int xSpace = 5;
    //Navigation buttons
    self.navigationItem.title = gelObject.name;
    UIBarButtonItem *emailWhole = [[UIBarButtonItem alloc]  initWithTitle:@"Email" style:UIBarButtonItemStyleBordered target:self action:@selector(emailWhole)];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    NSArray *rights = [[NSArray alloc]initWithObjects:emailWhole, edit, nil];
    self.navigationItem.rightBarButtonItems = rights;
    if(from) {
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc]  initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(backToHome)];
        self.navigationItem.leftBarButtonItem = anotherButton;
    }
    
    //stuff
    self.nameLabel.text = gelObject.name;
    self.dateLabel.text = gelObject.dateString;
    self.descriptionView.text = gelObject.description;
    self.descriptionView.editable = NO;
    self.ladderImageView.image = gelObject.ladder;
    
    //Largescrollview stuff
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, largeScrollView.frame.size.width, largeScrollView.frame.size.height)];
    imageView.image = gelObject.original;
    [self.largeScrollView addSubview:imageView];
    [self.largeScrollView setContentSize:self.largeScrollView.frame.size];
    self.largeScrollView.delegate = self;
    self.largeScrollView.maximumZoomScale = 2.0;
    [self applyGesturesToLargeScrollView:largeScrollView];
    
    //arrayScrollview
    for (int k = 0; k<[gelObject.pictures count]; k++) {
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        tempImageView.userInteractionEnabled = YES;
        tempImageView.tag = k;
        [self applyGesturesToSmallScrollView:tempImageView];
        tempImageView.image = [gelObject.pictures objectAtIndex:k];
        [arrayScrollView addSubview:tempImageView];
        x+=(xSpace+width);
    }
    [arrayScrollView setContentSize:CGSizeMake(x, height)];
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  imageView;
}

-(void)backToHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)applyGesturesToLargeScrollView:(UIView *) view {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailSingle)];    
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
        [view addGestureRecognizer:singleTapGestureRecognizer];        
}

-(void)applyGesturesToSmallScrollView:(UIView *) view {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageView:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [view addGestureRecognizer:singleTapGestureRecognizer];
}
-(void)changeImageView:(id) it {
    int filterIndex = [(UITapGestureRecognizer *) it view].tag;
    imageView.image = [gelObject.pictures objectAtIndex:filterIndex];
}

-(void) emailSingle {
    Class MailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if(MailClass !=nil) {
		if([MailClass canSendMail]) {
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
            picker.mailComposeDelegate = self;
            NSArray *recipitents = [NSArray arrayWithObject:@"abc@xyz.com"];
            [picker setToRecipients:recipitents];
            [picker setSubject:[NSString stringWithFormat:@"%@ %@",gelObject.name,gelObject.dateString]];
                NSData *imageData = UIImagePNGRepresentation(imageView.image);
                [picker addAttachmentData:imageData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@",gelObject.name]];
            [picker setMessageBody:gelObject.description isHTML:NO];
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
                                                       message:@"Error in opening framework" 
                                                      delegate:self cancelButtonTitle:@"Dismiss" 
                                             otherButtonTitles: nil];
		[error show];
	}
}

-(void)emailWhole {
    Class MailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if(MailClass !=nil) {
		if([MailClass canSendMail]) {
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
            picker.mailComposeDelegate = self;
            NSArray *recipitents = [NSArray arrayWithObject:@"abc@xyz.com"];
            [picker setToRecipients:recipitents];
            [picker setSubject:[NSString stringWithFormat:@"%@ %@",gelObject.name,gelObject.dateString]];
            for(int k = 0; k<[gelObject.pictures count]; k++) {
                NSData *imageData = UIImagePNGRepresentation([gelObject.pictures objectAtIndex:k]);
                [picker addAttachmentData:imageData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%i",gelObject.name,k]];
            }
            [picker setMessageBody:gelObject.description isHTML:NO];
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
                                                       message:@"Error in opening framework" 
                                                      delegate:self cancelButtonTitle:@"Dismiss" 
                                             otherButtonTitles: nil];
		[error show];
	}
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
}

-(void)edit {
    EditViewController *editor = [[EditViewController alloc]init];
    editor.gel = self.gelObject;
    [self.navigationController pushViewController:editor animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
