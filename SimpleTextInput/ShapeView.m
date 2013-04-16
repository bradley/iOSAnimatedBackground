//
//  ShapeView.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "ShapeView.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation ShapeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _red = RGBA(192, 116, 90, 1);
        _yellow = RGBA(238, 208, 110, 1);
        _green = RGBA(71, 161, 106, 1);
        _blue = RGBA(29, 63, 140, 1);
        
        _shapeID = 1; // DEFAULT
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [self randomColor]);
    CGContextSetStrokeColorWithColor(ctx, [self randomColor]);
    CGFloat frameWidth = [self frame].size.width;
    CGFloat frameHeight = [self frame].size.height;
    CGFloat smallSize = frameWidth > frameHeight ? frameHeight : frameWidth;
    CGFloat largeSize = frameWidth > frameHeight ? frameWidth : frameHeight;
    CGFloat frameSegment = largeSize / 5;

    // TRIANGLE
    if (_shapeID == 1) {
        // TRIANGLE
        CGContextBeginPath(ctx);
        CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMidY(rect));  // mid right
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
    else if (_shapeID == 2) {
        // CIRCLE
        CGRect circleRect = CGRectMake(0, 0, smallSize, smallSize);
        CGContextFillEllipseInRect(ctx, circleRect);
    }
    else {
        NSLog(@"%f, %f", frameWidth, frameHeight);
        UIBezierPath *curve = [UIBezierPath bezierPath];
        if (largeSize == frameWidth) {
            [curve moveToPoint:CGPointMake(frameSegment/2,frameHeight/2)];
            [curve addCurveToPoint:CGPointMake(frameWidth/2, frameHeight/2)
                     controlPoint1:CGPointMake((frameSegment) + (frameSegment / 2.40), frameHeight + (frameHeight / 2))
                     controlPoint2:CGPointMake((frameSegment * 2) - (frameSegment / 2.40), 0 - (frameHeight / 2))];
            [curve addCurveToPoint:CGPointMake(frameWidth - (frameSegment / 2), frameHeight/2)
                     controlPoint1:CGPointMake((frameSegment * 3) + (frameSegment / 2.40), frameHeight + (frameHeight / 2))
                     controlPoint2:CGPointMake((frameSegment * 4) - (frameSegment / 2.40), 0 - (frameHeight / 2))];
        }
        else {
            [curve moveToPoint:CGPointMake(frameWidth/2,frameSegment/2)];
            [curve addCurveToPoint:CGPointMake(frameWidth/2, frameHeight/2)
                     controlPoint1:CGPointMake(frameWidth + (frameWidth / 2), (frameSegment) + (frameSegment / 2.40))
                     controlPoint2:CGPointMake(0 - (frameWidth / 2), (frameSegment * 2) - (frameSegment / 2.40))];
            [curve addCurveToPoint:CGPointMake(frameWidth/2, frameHeight - (frameSegment / 2))
                     controlPoint1:CGPointMake(frameWidth + (frameWidth / 2), (frameSegment * 3) + (frameSegment / 2.40))
                     controlPoint2:CGPointMake(0 - (frameWidth / 2), (frameSegment * 4) - (frameSegment / 2.40))];
        }
        curve.lineWidth = 1;
        [curve stroke];
    }
}

- (CGColorRef)randomColor {
    int colorState = (arc4random() % 4) + 1; // random number between 1 and 4
    CGColorRef color;
    
    switch (colorState) {
        case 1:
            color = _red.CGColor;
            break;
        case 2:
            color = _green.CGColor;
            break;
        case 3:
            color = _blue.CGColor;
            break;
        case 4:
            color = _yellow.CGColor;
            break;
        default:
            color = _red.CGColor;
            NSLog(@"This should not be called.");
            break;
    }
    return color;
}


@end
