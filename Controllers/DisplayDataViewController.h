//
//  DisplayDataViewController
//  iGel1
//
//  Created by Ian Christie on 7/25/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class GelObject;

@interface DisplayDataViewController : UIViewController <MFMailComposeViewControllerDelegate,UIScrollViewDelegate>{
    GelObject *gelObject;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UITextView *descriptionView;
    IBOutlet UIScrollView *largeScrollView;
    UIImageView *imageView;
    IBOutlet UIImageView *ladderImageView;
    IBOutlet UIScrollView *arrayScrollView;
    BOOL from;
}

@property(nonatomic,retain) GelObject *gelObject;
@property(nonatomic,retain) IBOutlet UILabel *nameLabel;
@property(nonatomic,retain) IBOutlet UILabel *dateLabel;
@property(nonatomic,retain) IBOutlet UITextView *descriptionView;
@property(nonatomic,retain) IBOutlet UIScrollView *largeScrollView;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) IBOutlet UIImageView *ladderImageView;
@property(nonatomic,retain) IBOutlet UIScrollView *arrayScrollView;
@property(nonatomic) BOOL from;

-(void)backToHome;
-(void)applyGesturesToLargeScrollView:(UIView *) view;
-(void)applyGesturesToSmallScrollView:(UIView *) view;
-(void)changeImageView:(id) it;
-(void)emailSingle;

@end
