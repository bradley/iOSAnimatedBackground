//
//  MovingObject.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "MovingObject.h"
#import "ShapeView.h"

#define ARC4RANDOM_MAX 0x100000000
#define random_float(smallNumber, bigNumber) ((((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (bigNumber - smallNumber)) + smallNumber) 
#define degrees_to_radians(degrees) (degrees * M_PI / 180)

typedef struct {
    int type;
    CGFloat height;
    CGFloat width;
} shapeDefinition;

@implementation MovingObject

- (id)init {
    [NSException raise:@"Wrong init method called." format:@"Use initWithBounds:andPosition: for StarfieldView"];
}

- (id)initWithBounds:(CGRect)b {
    if (self = [super init]) {
        _bounds = b;
        _outerBounds = 100; // Space outside view bounds.
        _angle = 1;
        _clockwise = arc4random() % 2; // 0 or 1;
        _angleStep = random_float(0.3, 1.0);
        
        _position = [self randomOuterPosition];
        
        shapeDefinition s = [self newShape];
        _shape = [[ShapeView alloc]initWithFrame:CGRectMake(_position.x, _position.y, s.width, s.height)];
        _shape.shapeID = s.type;
    }
    return self;
}

- (int)randomSize {
    int min = 10;
    int max = 30;
    return (arc4random() % (max - min)) + min;
}

- (CGPoint)randomTrajectory {
    int r = arc4random() % 2 ? 1 : -1; // +/-1
    NSInteger x = (arc4random() % 5 + 1) * r; // random between 1 and 3 times r
    r = arc4random() % 2 ? 1 : -1; // +/-1
    NSInteger y = (arc4random() % 5 + 1) * r; // random between 1 and 3 times r
    
    if (fabsf(x) + fabsf(y) > 3) {
        _velocity = 0.2;
    }
    else {
        _velocity = [self randomVelocity];
    }
    
    return CGPointMake(x, y);
}

- (CGFloat)randomVelocity {
    // Random decimal between 0.1 and 0.8. This *slows*
    // the shapes.
    CGFloat min = 0.1;
    CGFloat max = 0.8;
    return random_float(min, max);
}

- (CGPoint)randomOuterPosition {
    int side = arc4random() % 3 + 1;
    int wallOffset = 5;
    int boundsWidth = [[NSNumber numberWithDouble:(_bounds.size.width)] integerValue] + _outerBounds;
    int boundsHeight = [[NSNumber numberWithDouble:(_bounds.size.height)] integerValue] + _outerBounds;
    int shapeHeightWithOffset = _shape.bounds.size.height + wallOffset;
    int shapeWidthWithOffset = _shape.bounds.size.width + wallOffset;
    
    _trajectory = [self randomTrajectory];
    
    NSInteger x;
    NSInteger y;
    
    switch (side) {
        case 1:
            x = (arc4random() % ((boundsWidth - shapeWidthWithOffset))) + shapeWidthWithOffset - _outerBounds;
            y = 0 + shapeHeightWithOffset - _outerBounds;
            
            _trajectory.y = fabsf(_trajectory.y);
            break;
        case 2:
            x = boundsWidth - shapeHeightWithOffset;
            y = (arc4random() % ((boundsHeight - shapeHeightWithOffset) )) + shapeHeightWithOffset - _outerBounds;
            
            _trajectory.x = fabsf(_trajectory.x) * -1;
            break;
        case 3:
            x = (arc4random() % ((boundsWidth - shapeWidthWithOffset))) + shapeWidthWithOffset - _outerBounds;
            y = boundsHeight - shapeHeightWithOffset;

            _trajectory.y = fabsf(_trajectory.y) * -1;
            break;
        case 4:
            x = 0 + shapeWidthWithOffset - _outerBounds;
            y = (arc4random() % ((boundsHeight - shapeHeightWithOffset))) + shapeHeightWithOffset - _outerBounds;
            
            _trajectory.x = fabsf(_trajectory.x);
            break;
        default:
            x = boundsWidth / 2;
            y = boundsHeight / 2;
            NSLog(@"This should never happen.");
            break;
    }
    
    //NSLog(@"%d, %d with trajectory: %f, %f", x, y, _trajectory.x, _trajectory.y);
    return CGPointMake(x, y);
}


- (void)checkForCollisions {
    // If we wanted the shape to bounce off walls we could make a function for
    // each collision type that reverses the coordinate for the trajectory.
    // For example, if the shape hit the bottom, we could do:
    //   _trajectory.y = -fabsf(_trajectory.y); // bounce
    if ((_position.x + (_shape.frame.size.width / 2)) >= _bounds.size.width + _outerBounds) {
         _position = [self randomOuterPosition];
    }
    else if ((_position.x - (_shape.frame.size.width / 2)) <= _bounds.origin.x - _outerBounds) {
         _position = [self randomOuterPosition];
    }
    else if ((_position.y + (_shape.frame.size.height / 2)) >= _bounds.size.height + _outerBounds) {
         _position = [self randomOuterPosition];
    }
    else if ((_position.y - (_shape.frame.size.height / 2)) <= _bounds.origin.y - _outerBounds) {
         _position = [self randomOuterPosition];
    }
}

- (void)update {
    [self checkForCollisions];
 
    CGPoint p = _position;
    p.x += _trajectory.x * _velocity;
    p.y += _trajectory.y * _velocity;
    
    _position = p;
    _shape.center = p;
    [self rotateView];
}

- (void)rotateView {
    CGAffineTransform rotationTransform = CGAffineTransformIdentity;
    rotationTransform = CGAffineTransformRotate(rotationTransform, degrees_to_radians(_angle));
    _shape.transform = rotationTransform;
    
    if (_clockwise == 1) {
        _angle = _angle >= 360 ? 1 : _angle + _angleStep;
    }
    else {
        _angle = _angle <= 1 ? 360 : _angle - _angleStep;
    }
}

- (shapeDefinition)newShape {
    shapeDefinition s;
    s.type = (arc4random() % 3) + 1;
    if (s.type == 3.0) {
        // If squiggly line type, let's help it look right
        // by giving it a more reliable size.
        s.width = (arc4random() % 81) + 20; // 20...100
        s.height = s.width / 5;
    }
    else {
        s.width = [self randomSize];
        s.height = [self randomSize];
    }
    return s;
}

@end
