//
//  InputViewController.h
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class StarfieldView;

@interface InputViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet StarfieldView *background;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (nonatomic) CADisplayLink *displayLink;
@end
