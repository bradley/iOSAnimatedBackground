//
//  ShapeView.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    /*
    NSLog(@"drawww");
    CGRect bounds = [self bounds];
    [[UIColor blackColor]set];
    UIRectFill(bounds); */
    
    /* Set UIView Border */
	/*
     // Get the contextRef
     CGContextRef contextRef = UIGraphicsGetCurrentContext();
     
     // Set the border width
     CGContextSetLineWidth(contextRef, 5.0);
     
     // Set the border color to RED
     CGContextSetRGBStrokeColor(contextRef, 255.0, 0.0, 0.0, 1.0);
     
     // Draw the border along the view edge
     CGContextStrokeRect(contextRef, rect);
     */
	
	/* Draw a circle */
	// Get the contextRef
	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	
	// Set the border width
	CGContextSetLineWidth(contextRef, 1.0);
	
	// Set the circle fill color to GREEN
	CGContextSetRGBFillColor(contextRef, 0.0, 255.0, 0.0, 1.0);
	
	// Set the cicle border color to BLUE
	CGContextSetRGBStrokeColor(contextRef, 0.0, 0.0, 255.0, 1.0);
	
	// Fill the circle with the fill color
	CGContextFillEllipseInRect(contextRef, rect);
	
	// Draw the circle border
	CGContextStrokeEllipseInRect(contextRef, rect);
}


@end
