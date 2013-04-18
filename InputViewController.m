//
//  InputViewController.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "InputViewController.h"
#import "StarfieldView.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    _defaultTextFrame = _descriptionText.frame;
    _defaultTextBackground = _descriptionText.backgroundColor;
    
    UIImage *resizableButton = [self colorImageForButton:[UIColor colorWithRed:86/255.0 green:87/255.0 blue:89/255.0 alpha:1]];
    UIImage *resizableButtonHighlighted = [self colorImageForButton:[UIColor colorWithRed:54/255.0 green:47/255.0 blue:71/255.0 alpha:1]];

    [_saveButton setBackgroundImage:resizableButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_saveButton setBackgroundImage:resizableButtonHighlighted forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_saveButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica" size:17.0], UITextAttributeFont, [UIColor clearColor], UITextAttributeTextShadowColor, nil] forState:UIControlStateNormal];
    
    [_cancelButton setTextColor:[UIColor colorWithRed:234/255.0 green:51/255.0 blue:66/255.0 alpha:1]];
    _cancelButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelEdit)];
    [_cancelButton addGestureRecognizer:tapGesture];

    
    CGRect actionBarFrame = [_keyboardActionsBar frame];
    actionBarFrame.origin.y += actionBarFrame.size.height;
    _keyboardActionsBar.frame = actionBarFrame;
    _defaultActionBarFrame = actionBarFrame;
}

- (UIImage *)colorImageForButton:(UIColor *)color {
    CGFloat verticalPadding = 10.0;
    CGFloat horizontalPadding = 67.0;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, (horizontalPadding * 2) + 1, (verticalPadding * 2) + 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [image resizableImageWithCapInsets:UIEdgeInsetsMake(horizontalPadding, verticalPadding, horizontalPadding, verticalPadding)];
    
    return image;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)moveTextViewForKeyboard:(NSNotification*)aNotification up:(BOOL)up {
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (up) {
        CGRect newTextFrame = _descriptionText.frame;
        CGRect newActionBarFrame = _keyboardActionsBar.frame;
        CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
        
        CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
        
        newTextFrame.size.width = screenFrame.size.width;
        newTextFrame.size.height = screenFrame.size.height - keyboardFrame.size.height - newActionBarFrame.size.height;
        newTextFrame.origin.x = 0;
        newTextFrame.origin.y = 0;
        _descriptionText.frame = newTextFrame;
        _descriptionText.backgroundColor = [UIColor whiteColor];

        newActionBarFrame.origin.y = newTextFrame.size.height;
        _keyboardActionsBar.frame = newActionBarFrame;
    }
    else {
        _descriptionText.frame = _defaultTextFrame;
        _descriptionText.backgroundColor = _defaultTextBackground;
        _keyboardActionsBar.frame = _defaultActionBarFrame;
    }
    
    [UIView commitAnimations];
}

- (void)keyboardWillBeShown:(NSNotification*)aNotification
{
    _backupText = _descriptionText.text;
    [self moveTextViewForKeyboard:aNotification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    [self moveTextViewForKeyboard:aNotification up:NO];
}

- (IBAction)saveDescription:(id)sender {
    [self.view endEditing:YES];
}

- (void)cancelEdit {
    [self.view endEditing:YES];
    _descriptionText.text = _backupText;
}

-(void)gameLoop
{
    [_background moveShapes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
