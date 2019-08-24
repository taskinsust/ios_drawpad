//
//  SettingsViewController.m
//  DrawPad
//
//  Created by Ray Wenderlich on 9/3/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import "SettingsViewControllerPad.h"
#define AdMob_ID @"ca-app-pub-2603477123151360/5001059531"

@interface SettingsViewControllerPad ()

@end

@implementation SettingsViewControllerPad

@synthesize brushControlX;
@synthesize opacityControlX;
@synthesize brushPreviewX;
@synthesize opacityPreviewX;
@synthesize brushValueLabelX;
@synthesize opacityValueLabelX;
@synthesize brushX;
@synthesize opacityX;
@synthesize delegate;
@synthesize redControlX;
@synthesize greenControlX;
@synthesize blueControlX;
@synthesize redLabelX;
@synthesize greenLabelX;
@synthesize blueLabelX;
@synthesize redX;
@synthesize greenX;
@synthesize blueX;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBrushControlX:nil];
    [self setOpacityControlX:nil];
    [self setBrushPreviewX:nil];
    [self setOpacityPreviewX:nil];
    [self setBrushValueLabelX:nil];
    [self setOpacityValueLabelX:nil];
    [self setRedControlX:nil];
    [self setGreenControlX:nil];
    [self setBlueControlX:nil];
    [self setRedLabelX:nil];
    [self setGreenLabelX:nil];
    [self setBlueLabelX:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    // ensure the values displayed are the current values
    
    int redIntValue = self.redX * 255.0;
    self.redControlX.value = redIntValue;
    [self sliderChangedX:self.redControlX];
    
    int greenIntValue = self.greenX * 255.0;
    self.greenControlX.value = greenIntValue;
    [self sliderChangedX:self.greenControlX];
    
    int blueIntValue = self.blueX * 255.0;
    self.blueControlX.value = blueIntValue;
    [self sliderChangedX:self.blueControlX];
    
    self.brushControlX.value = self.brushX;
    [self sliderChangedX:self.brushControlX];
    
    self.opacityControlX.value = self.opacityX;
    [self sliderChangedX:self.opacityControlX];
    
    [self showAdmob];
    
}



-(void)showAdmob{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,self.view.frame.size.height - GAD_SIZE_728x90.height,GAD_SIZE_728x90.width,GAD_SIZE_728x90.height)];
        
        
        bannerView_.adUnitID = AdMob_ID;
        
        bannerView_.rootViewController = self;
        
        [self.view addSubview:bannerView_];
        
        [bannerView_ loadRequest:[GADRequest request]];
        
    }
    else
    {
        bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,self.view.frame.size.height - GAD_SIZE_320x50.height,GAD_SIZE_320x50.width,GAD_SIZE_320x50.height)];
        
        
        bannerView_.adUnitID = AdMob_ID;
        
        bannerView_.rootViewController = self;
        
        [self.view addSubview:bannerView_];
        
        [bannerView_ loadRequest:[GADRequest request]];
        
    }
}



- (IBAction)closeSettingsX:(id)sender {
    [self.delegate closeSettings:self];
}

- (IBAction)sliderChangedX:(id)sender {
    
    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider == self.brushControlX) {
        
        self.brushX = self.brushControlX.value;
        self.brushValueLabelX.text = [NSString stringWithFormat:@"%.1f", self.brushX];
        
    } else if(changedSlider == self.opacityControlX) {
        
        self.opacityX = self.opacityControlX.value;
        self.opacityValueLabelX.text = [NSString stringWithFormat:@"%.1f", self.opacityX];
        
    } else if(changedSlider == self.redControlX) {
        
        self.redX = self.redControlX.value/255.0;
        self.redLabelX.text = [NSString stringWithFormat:@"Red: %d", (int)self.redControlX.value];
        
    } else if(changedSlider == self.greenControlX){
        
        self.greenX = self.greenControlX.value/255.0;
        self.greenLabelX.text = [NSString stringWithFormat:@"Green: %d", (int)self.greenControlX.value];
    } else if (changedSlider == self.blueControlX){
        
        self.blueX = self.blueControlX.value/255.0;
        self.blueLabelX.text = [NSString stringWithFormat:@"Blue: %d", (int)self.blueControlX.value];
        
    }
    
    UIGraphicsBeginImageContext(self.brushPreviewX.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brushX);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.redX, self.greenX, self.blueX, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.brushPreviewX.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.opacityPreviewX.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brushX);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.redX, self.greenX, self.blueX, self.opacityX);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.opacityPreviewX.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

@end
