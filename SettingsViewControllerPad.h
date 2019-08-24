//
//  SettingsViewControllerPad.h
//  DrawPad
//
//  Created by Rintu on 2/21/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@protocol SettingsViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end

@interface SettingsViewControllerPad : UIViewController{
    
    GADBannerView *bannerView_;
}

@property (weak, nonatomic) IBOutlet UISlider *brushControlX;
@property (weak, nonatomic) IBOutlet UISlider *opacityControlX;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreviewX;
@property (weak, nonatomic) IBOutlet UIImageView *opacityPreviewX;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabelX;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabelX;
@property (weak, nonatomic) id<SettingsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *redControlX;
@property (weak, nonatomic) IBOutlet UISlider *greenControlX;
@property (weak, nonatomic) IBOutlet UISlider *blueControlX;
@property (weak, nonatomic) IBOutlet UILabel *redLabelX;
@property (weak, nonatomic) IBOutlet UILabel *greenLabelX;
@property (weak, nonatomic) IBOutlet UILabel *blueLabelX;

@property CGFloat brushX;
@property CGFloat opacityX;
@property CGFloat redX;
@property CGFloat greenX;
@property CGFloat blueX;

- (IBAction)closeSettingsX:(id)sender;


- (IBAction)sliderChangedX:(id)sender;

@end
