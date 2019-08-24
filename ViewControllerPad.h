//
//  ViewControllerPad.h
//  DrawPad
//
//  Created by Rintu on 2/21/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import <Social/Social.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"


@interface ViewControllerPad : UIViewController <SettingsViewControllerDelegate, UIActionSheetDelegate> {
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    
    SLComposeViewController *slComposeViewController;
    
    GADBannerView *bannerView_;
}

@property(nonatomic, strong) GADInterstitial *interstitial;


@property (weak, nonatomic) IBOutlet UIImageView *mainImageX;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImageX;

- (IBAction)pencilPressedX:(id)sender;


- (IBAction)eraserPressedX:(id)sender;
- (IBAction)resetX:(id)sender;

- (IBAction)saveX:(id)sender;


- (IBAction)twitterX:(id)sender;

- (IBAction)fbX:(id)sender;
@end
