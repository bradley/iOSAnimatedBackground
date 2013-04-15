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

- (id)initWithBounds:(CGRect)b andPosition:(CGPoint)p;

- (BOOL)positionIsInsideBounds;
- (void)update;

- (void)hitTop;
- (void)hitRight;
- (void)hitBottom;
- (void)hitLeft;

@end
