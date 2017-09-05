//
//  EditViewController.h
//  iGel1
//
//  Created by Ian Christie on 7/21/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FilterViewController.h"

@class GelObject;

@interface EditViewController : UIViewController <UITextViewDelegate,MFMailComposeViewControllerDelegate,FilterDelegate>{
    GelObject *gel;
    
    //view stuff
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIButton *saveButton;
    IBOutlet UITextView *tV;
    IBOutlet UITextField *textField;
}

@property(nonatomic,retain) GelObject *gel;

// view stuff
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) IBOutlet UILabel *dateLabel;
@property(nonatomic,retain) IBOutlet UIButton *saveButton;
@property(nonatomic,retain) IBOutlet UITextView *tV;
@property(nonatomic,retain) IBOutlet UITextField *textField;

-(IBAction)nameEntered:(id)sender;
-(IBAction)pushedFilter:(id)sender;
-(IBAction)pushedSaved:(id)sender;
-(IBAction)sendPhoto;

@end
