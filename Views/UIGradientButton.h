//
//  UIGradientButton.h
//  iGel1
//
//  Created by Ian Christie on 8/25/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIGradientButton : UIButton{
    CAGradientLayer *shineLayer;
    CALayer         *highlightLayer;
}

@end
