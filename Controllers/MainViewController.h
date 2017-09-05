//
//  ViewController.h
//  iGel1
//
//  Created by Ian Christie on 7/20/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MainViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate>

- (IBAction)pushedAbout:(id)sender;
- (IBAction)pushedContact:(id)sender;
- (IBAction)pushedCamera:(id)sender;
- (IBAction)pushedReferences:(id)sender;
- (IBAction)pushedArchive:(id)sender;

@end
