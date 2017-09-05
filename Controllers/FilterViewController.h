//
//  FilterViewController.h
//  iGel1
//
//  Created by Ian Christie on 7/22/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreImage/CoreImage.h"

@protocol FilterDelegate;
@interface FilterViewController : UIViewController {
    UIImage *uiImage;
    CIImage *ciImage;
    NSMutableArray *images;
    IBOutlet UIImageView *imageView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIScrollView *buttonScrollView;
    CIContext *context;
    //filters
    CIFilter *negative;
    CIFilter *gammaAdjust;
    CIFilter *exposureAdjust;
    CIFilter *colorControl;
    //image scrollView
    int x;
    int y;
    int height;
    int width;
    int xSpace;
    //button scrollView
    int bX;
    int bY;
    int bHeight;
    int bWidth;
    int bXSpace;
    
    id <FilterDelegate> delegate;
}

@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) NSMutableArray *images;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain) IBOutlet UIScrollView *buttonScrollView;
@property(nonatomic, assign) id <FilterDelegate> delegate;

-(IBAction)pushedSave:(id)sender;
-(IBAction)pushedNegative:(id)sender;
-(IBAction)pushedGammaAdjust:(id)sender;
-(IBAction)pushedExposureAdjust:(id)sender;
-(IBAction)pushedContrastAdjust:(id)sender;
-(IBAction)pushedSaturationAdjust:(id)sender;
-(IBAction)pushedBrightnessAdjust:(id)sender;

-(void)createSlider:(NSString *)selectorName lowValue:(float)lV highValue:(float)hV startingValue:(float)sV;

-(void)sliderExposure:(id)sender;
-(void)sliderGamma:(id)sender;
-(void)sliderContrast:(id)sender;
-(void)sliderSaturation:(id)sender;
-(void)sliderBrightness:(id)sender;

-(void) createButtonScrollView;
-(void) getRidOfAllSliders;
-(void)applyGesturesToSmallScrollView:(UIView *) view;
-(void)changeImageView:(id) it;

@end

@protocol FilterDelegate <NSObject>

@required

-(void)save:(UIImage *)filteredImage;

@end
