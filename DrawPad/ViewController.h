//
//  ViewController.h
//  DrawPad
//
//  Created by Ray Wenderlich on 9/3/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import <Social/Social.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"


@interface ViewController : UIViewController <SettingsViewControllerDelegate, UIActionSheetDelegate> {
    
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


@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

- (IBAction)pencilPressed:(id)sender;


- (IBAction)eraserPressed:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)save:(id)sender;


- (IBAction)twitter:(id)sender;

- (IBAction)fb:(id)sender;

@end
