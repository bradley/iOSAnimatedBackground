//
//  MovingObject.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "MovingObject.h"
#import "ShapeView.h"

@implementation MovingObject

- (id)init {
    [NSException raise:@"Wrong init method called." format:@"Use initWithBounds:andPosition: for StarFieldView"];
}

- (id)initWithBounds:(CGRect)b andPosition:(CGPoint)p {
    if (self = [super init]) {
        _bounds = b;
        _position = p;
        _trajectory = CGPointMake(1, 1);
        _velocity = 1;
        
        if (![self positionIsInsideBounds]) {
            NSLog(@"Position changed to center");
            _position = CGPointMake(_bounds.size.width/2, _bounds.size.height/2);
        }
        
        _shape = [[ShapeView alloc]initWithFrame:CGRectMake(_position.x, _position.y, 15, 15)];
    }
    return self;
}

- (BOOL)positionIsInsideBounds {
    if  (_position.x < _bounds.origin.x || _position.x > _bounds.size.width ||
         _position.y < _bounds.origin.y || _position.y > _bounds.size.height ) {
        NSLog(@"Position is outside bounds!");
        return NO;
    }
    return YES;
}

- (void)checkForCollisions {
    if ((_position.x + (_shape.frame.size.width / 2)) >= _bounds.size.width) {
        [self hitRight];
    }
    else if ((_position.x - (_shape.frame.size.width / 2)) <= _bounds.origin.x) {
        [self hitLeft];
    }
    else if ((_position.y + (_shape.frame.size.height / 2)) >= _bounds.size.height) {
        [self hitBottom];
    }
    else if ((_position.y - (_shape.frame.size.height / 2)) <= _bounds.origin.y) {
        [self hitTop];
    }
}

- (void)update {
    [self checkForCollisions];
 
    CGPoint p = _position;
    p.x += _trajectory.x * _velocity;
    p.y += _trajectory.y * _velocity;
    
    _position = p;
    _shape.center = p;
}

- (void)hitTop {
    _trajectory.y = fabsf(_trajectory.y);
}

- (void)hitRight {
    _trajectory.x = -fabsf(_trajectory.x);
}

- (void)hitBottom {
    _trajectory.y = -fabsf(_trajectory.y);
}

- (void)hitLeft {
    _trajectory.x = fabsf(_trajectory.x);
}


@end
