//
//  ViewController.m
//  captimosample
//
//  Created by Timothy Weisser on 11/7/12.
//  Copyright (c) 2012 Captimo, Inc. All rights reserved.
//

#import "ViewController.h"

//helper function for converting
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

#define SCALE_FACTOR 3
#define ANIM_DURATION 2
#define TRANS_ANGLE DEGREES_TO_RADIANS(-180)

#define TRANS_X 0.0
#define TRANS_Y -100.0

#define DO_SPIN 1

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _counter = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startText:(id)sender
{
    ++_counter;
    
    //unhide and set the text
    self.textFloating.hidden = NO;
    _oldCenter = self.textFloating.center;
    
    
    //format our floating text
    NSString* output = [NSString stringWithFormat:@"+%d", _counter * 10];
    self.textFloating.text = output;
    
    //start the scale and movement animation on the label
    /*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:ANIM_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(SCALE_FACTOR, SCALE_FACTOR);
    //CGAffineTransform rotateTrans = CGAffineTransformMakeRotation(angle * M_PI / 180);
    self.textFloating.transform = scaleTrans; //CGAffineTransformConcat(scaleTrans, rotateTrans);
    //angle = (angle == 180 ? 360 : 180);
    //scaleFactor = (scaleFactor == 2 ? 1 : 2);
    //boxView.center = location;
    [UIView commitAnimations];
    */
    
    [UIView animateWithDuration:ANIM_DURATION
                          delay:0.0
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         CGAffineTransform scaleTrans = CGAffineTransformMakeScale(SCALE_FACTOR, SCALE_FACTOR);
                         CGAffineTransform transTrans = CGAffineTransformMakeTranslation(TRANS_X, TRANS_Y);
                         
                        #if DO_SPIN
                         if((_counter & 0x01) == 0)
                         {
                             //this really needs to be in 3D and rotate on the X-axis for a true spin, but then
                             // I'd have to transform the label to a layer.. :(
                             CGAffineTransform rotateTrans = CGAffineTransformMakeRotation((TRANS_ANGLE));
                             scaleTrans = CGAffineTransformConcat(rotateTrans, scaleTrans);
                         }
                        #endif
                         
                         self.textFloating.transform = CGAffineTransformConcat(scaleTrans, transTrans);
                         
                     } 
                     completion:^(BOOL finished){
                         self.textFloating.transform = CGAffineTransformIdentity;
                         self.textFloating.hidden = YES;
                         self.textFloating.center = _oldCenter;
                     }
    ];
}
@end
