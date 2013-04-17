//
//  StarfieldView.m
//  SimpleTextInput
//
//  Created by Bradley Griffith on 4/14/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "StarfieldView.h"
#import "MovingObject.h"
#import "ShapeView.h"

@implementation StarfieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// Called instead of initWithFrame by XIB 
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        CGRect bounds = [self bounds];
        _shapes = [[NSMutableArray alloc] init];
        int shapeCount = 10;
        
        for (int i = 0; i < shapeCount; i++) {
            MovingObject *mo = [[MovingObject alloc] initWithBounds:bounds];
            ShapeView *shape = [mo shape];
            
            [_shapes addObject:mo];
            [self insertSubview:shape atIndex:0];
            //[self addSubview:shape];
            
            shape.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            shape.opaque = NO;
        }
    }
    return self;
}

- (void)moveShapes {
    for (MovingObject *mo in _shapes) {
        [mo update];
    }
}

@end
