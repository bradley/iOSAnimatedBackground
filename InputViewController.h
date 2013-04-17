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

@interface InputViewController : UIViewController <UITextViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIToolbar *keyboardActionsBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *cancelButton;

@property (weak, nonatomic) IBOutlet StarfieldView *background;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) CGRect defaultTextFrame;
@property (nonatomic) CGRect defaultActionBarFrame;
@property (nonatomic) UIColor *defaultTextBackground;
@property (nonatomic) NSString *backupText;

- (IBAction)saveDescription:(id)sender;
@end
