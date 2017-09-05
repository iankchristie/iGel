//
//  About.h
//  iGel1
//
//  Created by Ian Christie on 7/26/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface About : UIViewController {
    IBOutlet UILabel *label;
    IBOutlet UIButton *button;
}

@property(nonatomic, retain) IBOutlet UILabel *label;
@property(nonatomic, retain) IBOutlet UIButton *button;

-(IBAction)alterLabel:(id)sender;

@end
