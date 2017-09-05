//
//  About.m
//  iGel1
//
//  Created by Ian Christie on 7/26/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize label;
@synthesize button;

-(IBAction)alterLabel:(id)sender {
    NSMutableString *temp = [NSMutableString stringWithFormat:@"%@",label.text];
    [temp appendString:@""];
    label.text = temp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    label.text = @"Ian's First App";
    
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
