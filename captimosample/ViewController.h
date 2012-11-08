//
//  ViewController.h
//  captimosample
//
//  Created by Timothy Weisser on 11/7/12.
//  Copyright (c) 2012 Captimo, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    unsigned int _counter;
    CGPoint _oldCenter;
}

@property (weak, nonatomic) IBOutlet UILabel *textFloating;
@property (weak, nonatomic) IBOutlet UIButton *buttonText;

- (IBAction)startText:(id)sender;

@end
