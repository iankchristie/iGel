//
//  AppDelegate.h
//  iGel1
//
//  Created by Ian Christie on 7/20/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GelObject;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(NSString *) getDataFilePath;

@end
