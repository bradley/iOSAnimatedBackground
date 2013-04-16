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
}

-(void)gameLoop
{
    [_background moveShapes];
    
    //Here you could add your collision detection code
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
