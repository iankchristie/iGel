//
//  FilterViewController.m
//  iGel1
//
//  Created by Ian Christie on 7/22/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "FilterViewController.h"
#import "UIGradientButton.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

@synthesize image;
@synthesize images;
@synthesize imageView;
@synthesize scrollView;
@synthesize buttonScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(pushedSave:)];
    //image scrollView
    x = 5;
    y = 5;
    height = 50;
    width = 50;
    xSpace = 5;
    //button scrollView
    bX = 5;
    bY = 5;
    bHeight = 35;
    bWidth = 100;
    bXSpace = 15;
    //other
    context = [CIContext contextWithOptions:nil];
    images = [[NSMutableArray alloc]init];
    //filters
    negative = [CIFilter filterWithName:@"CIColorInvert"];
    gammaAdjust = [CIFilter filterWithName:@"CIGammaAdjust"];
    exposureAdjust = [CIFilter filterWithName:@"CIExposureAdjust"];
    colorControl = [CIFilter filterWithName:@"CIColorControls"];
    [images addObject:image];
    imageView.image = image;
    //Button Scroll View
    [self createButtonScrollView];
    //image scrollView
    for (int k = 0; k<[images count]; k++) {
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        tempImageView.image = [images objectAtIndex:k];
        tempImageView.userInteractionEnabled=YES;
        tempImageView.tag = k;
        [self applyGesturesToSmallScrollView:tempImageView];
        [scrollView addSubview:tempImageView];
        x+=(xSpace+width);
    }
    [scrollView setContentSize:CGSizeMake(x, height)];
}

-(void) createButtonScrollView {
    NSArray *titleArray = [[NSArray alloc]initWithObjects:@"Negative", @"Gamma", @"Exposure", @"Contrast", @"Saturation", @"Brightness",
                           @"Highlight", @"", nil];
    NSArray *selectorArray = [[NSArray alloc]initWithObjects:@"pushedNegative:", @"pushedGammaAdjust:", @"pushedExposureAdjust:",
                                                             @"pushedContrastAdjust:", @"pushedSaturationAdjust:", @"pushedBrightnessAdjust:",
                                                             @"pushedHighlightAdjust:",nil];
    for(int k = 0; k <6; k++) {
        UIGradientButton *temp = [[UIGradientButton alloc]initWithFrame:CGRectMake(bX, bY, bWidth, bHeight)];
        [temp setTitle:[titleArray objectAtIndex:k] forState:UIControlStateNormal];
        [temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        temp.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
        [temp addTarget:self action:NSSelectorFromString([selectorArray objectAtIndex:k]) forControlEvents:UIControlEventTouchUpInside];
        [buttonScrollView addSubview:temp];
        bX+=(bWidth+bXSpace);
    }
    [buttonScrollView setContentSize:CGSizeMake(bX, buttonScrollView.frame.size.height)];
}

-(IBAction)pushedNegative:(id)sender {
    [self getRidOfAllSliders];
    ciImage = [[CIImage alloc]initWithImage:imageView.image];
    [negative setValue:ciImage forKey:@"inputImage"];
    CIImage *outputImage = [negative outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    imageView.image= newImg;
    CGImageRelease(cgimg);
}

-(IBAction)pushedGammaAdjust:(id)sender {
    [self getRidOfAllSliders];
    ciImage = [[CIImage alloc]initWithImage:imageView.image];
    [gammaAdjust setValue:ciImage forKey:@"inputImage"];
    [self createSlider:@"sliderGamma:" lowValue:.1 highValue:20.0 startingValue:1.0];
}

-(void)sliderGamma:(id)sender {
    UISlider *slider = (UISlider *) sender;
    float temp = [slider value];
    [gammaAdjust setValue:[NSNumber numberWithFloat:temp] forKey:@"inputPower"];
    CIImage *outputImage = [gammaAdjust outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    imageView.image = newImg;
    CGImageRelease(cgimg);
}

-(IBAction)pushedExposureAdjust:(id)sender {
    [self getRidOfAllSliders];
    ciImage = [[CIImage alloc]initWithImage:imageView.image];
    [exposureAdjust setValue:ciImage forKey:@"inputImage"];
    [self createSlider:@"sliderExposure:" lowValue:-10.0 highValue:10.0 startingValue:0.0];
}

-(void)sliderExposure:(id)sender {
    UISlider *slider = (UISlider *) sender;
    float temp = [slider value];
    [exposureAdjust setValue:[NSNumber numberWithFloat:temp] forKey:@"inputEV"];
    CIImage *outputImage = [exposureAdjust outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    imageView.image = newImg;
    CGImageRelease(cgimg);
}

-(IBAction)pushedContrastAdjust:(id)sender {
    [self getRidOfAllSliders];
    ciImage = [[CIImage alloc]initWithImage:imageView.image];
    [colorControl setValue:ciImage forKey:@"inputImage"];
    [self createSlider:@"sliderContrast:" lowValue:0.0 highValue:4.0 startingValue:1.0];
}

-(void)sliderContrast:(id)sender {
    UISlider *slider = (UISlider *) sender;
    float temp = [slider value];
    [colorControl setValue:[NSNumber numberWithFloat:temp] forKey:@"inputContrast"];
    CIImage *outputImage = [colorControl outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    imageView.image = newImg;
    CGImageRelease(cgimg);
}

-(IBAction)pushedSaturationAdjust:(id)sender {
    [self getRidOfAllSliders];
    ciImage = [[CIImage alloc]initWithImage:imageView.image];
    [colorControl setValue:ciImage forKey:@"inputImage"];
    [self createSlider:@"sliderSaturation:" lowValue:0.0 highValue:2.0 startingValue:1.0];
}

-(void)sliderSaturation:(id)sender {
    UISlider *slider = (UISlider *) sender;
    float temp = [slider value];
    [colorControl setValue:[NSNumber numberWithFloat:temp] forKey:@"inputSaturation"];
    CIImage *outputImage = [colorControl outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    imageView.image = newImg;
    CGImageRelease(cgimg);
}

-(IBAction)pushedBrightnessAdjust:(id)sender {
    [self getRidOfAllSliders];
    ciImage = [[CIImage alloc]initWithImage:imageView.image];
    [colorControl setValue:ciImage forKey:@"inputImage"];
    [self createSlider:@"sliderBrightness:" lowValue:-1.0 highValue:1.0 startingValue:0.0];
}

-(void)sliderBrightness:(id)sender {
    UISlider *slider = (UISlider *) sender;
    float temp = [slider value];
    [colorControl setValue:[NSNumber numberWithFloat:temp] forKey:@"inputBrightness"];
    CIImage *outputImage = [colorControl outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    imageView.image = newImg;
    CGImageRelease(cgimg);
}

-(void)createSlider:(NSString *)selectorName lowValue:(float)lV highValue:(float)hV startingValue:(float)sV {
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(60, 325, 200, 25)];
    [slider addTarget:self action:NSSelectorFromString(selectorName) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = lV;
    slider.maximumValue = hV;
    slider.value = sV;
    slider.continuous = YES;
    [self.view addSubview:slider];
}

-(IBAction)pushedSave:(id)sender {
    [images addObject:imageView.image];
    UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    tempImageView.alpha = 0.0;
    tempImageView.image = imageView.image;
    tempImageView.userInteractionEnabled=YES;
    tempImageView.tag = [images count]-1;
    [self applyGesturesToSmallScrollView:tempImageView];
    [scrollView addSubview:tempImageView];
    [UIView animateWithDuration:1.0 animations:^{tempImageView.alpha=1.0;}];
    x+=(xSpace+width);
    [scrollView setContentSize:CGSizeMake(x, height)];
    [scrollView scrollRectToVisible:CGRectMake(tempImageView.frame.origin.x+xSpace,tempImageView.frame.origin.y,tempImageView.frame.size.width,tempImageView.frame.size.height) animated:YES];
    [scrollView flashScrollIndicators];
    
    //delegate stuff AKA sending data back
    if (self.delegate != nil) {
        if ([self.delegate conformsToProtocol:@protocol(FilterDelegate)]){
            if ([self.delegate respondsToSelector:@selector(save:)]){
                [self.delegate save:imageView.image];
            }
        }
    }
}

-(void) getRidOfAllSliders {
    for(id temp in [self.view subviews]){
        if([temp isKindOfClass:[UISlider class]]) {
            [temp removeFromSuperview];
        }
    }
}

-(void)applyGesturesToSmallScrollView:(UIView *) view {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageView:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [view addGestureRecognizer:singleTapGestureRecognizer];
}

-(void)changeImageView:(id) it {
    [self getRidOfAllSliders];
    int filterIndex = [(UITapGestureRecognizer *) it view].tag;
    imageView.image = [images objectAtIndex:filterIndex];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
