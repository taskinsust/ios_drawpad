//
//  ViewController.m
//  DrawPad
//
//  Created by Ray Wenderlich on 9/3/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import "ViewControllerPad.h"
#define AdMob_ID @"ca-app-pub-2603477123151360/5001059531"
#import "SettingsViewControllerPad.h"
#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>

@interface ViewControllerPad ()

@end

@implementation ViewControllerPad
@synthesize mainImageX;
@synthesize tempDrawImageX,interstitial;

- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    [super viewDidLoad];
    
    [self loadAdmobFullscreen];
    
    [NSTimer scheduledTimerWithTimeInterval:15.0
                                     target:self
                                   selector:@selector(showAdmobFulscreen)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)viewDidUnload
{
    [self setMainImageX:nil];
    [self setTempDrawImageX:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
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


- (IBAction)pencilPressedX:(id)sender {
    
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
    }
}

- (IBAction)eraserPressedX:(id)sender {
    
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
}

- (IBAction)resetX:(id)sender {
    
    self.mainImageX.image = nil;
    
}



- (IBAction)saveX:(id)sender {
    
    
    UIGraphicsBeginImageContextWithOptions(self.mainImageX.bounds.size, NO, 0.0);
    [self.mainImageX.image drawInRect:CGRectMake(0, 0, self.mainImageX.frame.size.width, self.mainImageX.frame.size.height)];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        
        [Chartboost showInterstitial:CBLocationHomeScreen];
        
        [self showAdmobFulscreen];

        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image successfully saved in Photos"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImageX.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImageX.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImageX setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImageX.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImageX.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImageX.frame.size);
    [self.mainImageX.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImageX.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImageX.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImageX.image = nil;
    UIGraphicsEndImageContext();
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SettingsViewControllerPad * settingsVC = (SettingsViewControllerPad *)segue.destinationViewController;
    settingsVC.delegate = self;
    settingsVC.brushX = brush;
    settingsVC.opacityX = opacity;
    settingsVC.redX = red;
    settingsVC.greenX = green;
    settingsVC.blueX = blue;
    
}

#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
    
    brush = ((SettingsViewControllerPad*)sender).brushX;
    opacity = ((SettingsViewControllerPad*)sender).opacityX;
    red = ((SettingsViewControllerPad*)sender).redX;
    green = ((SettingsViewControllerPad*)sender).greenX;
    blue = ((SettingsViewControllerPad*)sender).blueX;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)fbX:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            }
            else{

                [self showAdmobFulscreen];
                
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Done" message:@"Image posted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
        };
        
        
        
        UIGraphicsBeginImageContextWithOptions(self.mainImageX.bounds.size, NO,0.0);
        [self.mainImageX.image drawInRect:CGRectMake(0, 0, self.mainImageX.frame.size.width, self.mainImageX.frame.size.height)];
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        slComposeViewController.completionHandler =myBlock;
        
        [slComposeViewController addImage:SaveImage];
        [slComposeViewController setInitialText:@"Check out my sketch on the Sketchup app:"];
        [slComposeViewController addURL:[NSURL URLWithString:@"http://goo.gl/8bZEZP"]];
        [self presentViewController:slComposeViewController animated:YES completion:NULL];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No FB Account" message:@"There are no facebook account configured. You can configure or create account in settings." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (IBAction)twitterX:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            }
            else{
                
                [self showAdmobFulscreen];

                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Done" message:@"Image posted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        };
        
        
        
        UIGraphicsBeginImageContextWithOptions(self.mainImageX.bounds.size, NO,0.0);
        [self.mainImageX.image drawInRect:CGRectMake(0, 0, self.mainImageX.frame.size.width, self.mainImageX.frame.size.height)];
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        slComposeViewController.completionHandler =myBlock;
        
        [slComposeViewController addImage:SaveImage];
        [slComposeViewController setInitialText:@"Check out my sketch on the Sketchup app:"];
        [slComposeViewController addURL:[NSURL URLWithString:@"http://goo.gl/8bZEZP"]];
        [self presentViewController:slComposeViewController animated:YES completion:NULL];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Account" message:@"There are no twitter account configured. You can configure or create account in settings." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)loadAdmobFullscreen{
    
    self.interstitial = [[GADInterstitial alloc] init];
    
    self.interstitial.adUnitID = @"ca-app-pub-9079664095868787/8334631551";
    
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
    
    // Requests test ads on simulators.
    //request.testDevices = @[ GAD_SIMULATOR_ID ];
}

-(void)showAdmobFulscreen{
    
    [self.interstitial presentFromRootViewController:self];
}

@end
