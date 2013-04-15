//
//  InputViewController.h
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class MovingObject, ShapeView;

@interface InputViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (nonatomic, retain) MovingObject *movingObject;
@property (nonatomic, retain) ShapeView *shape;
@property (nonatomic) CADisplayLink *displayLink;
@end
