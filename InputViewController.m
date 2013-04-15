//
//  InputViewController.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "InputViewController.h"
#import "MovingObject.h"
#import "ShapeView.h"

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
    CGRect bounds = [_backgroundView bounds];
    _movingObject = [[MovingObject alloc] initWithBounds:bounds andPosition:CGPointMake(bounds.size.width / 2, bounds.size.height / 2)];
    _shape = [_movingObject shape];
    [_backgroundView insertSubview:_shape belowSubview:_descriptionText];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)gameLoop
{
    [_movingObject update];
    
    //Here you could add your collision detection code
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
