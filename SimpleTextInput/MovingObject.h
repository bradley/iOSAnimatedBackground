//
//  MovingObject.h
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class ShapeView;

@interface MovingObject : NSObject
{
    
}
@property (nonatomic, retain) ShapeView *shape;
@property CGRect bounds;
@property CGPoint position;
@property CGPoint trajectory;
@property CGFloat velocity;
@property NSInteger outerBounds;
@property CGFloat angle;
@property CGFloat angleStep;
@property int clockwise;

- (id)initWithBounds:(CGRect)b;

- (void)update;

@end
