//
//  SAWSineWaveView.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-20.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWSineWaveView.h"

@implementation SAWSineWaveView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 255.0, 255.0, 255.0, 255.0); // yellow line
//    CGContextBeginPath(context);
//    CGMutablePathRef path = CGPathCreateMutable();
//    float x=125;
//    float y=338;
//    float yc=75;
//    float w=0;
//    while (w<=338){ //rectLayer.frame.size.width) {
//        CGPathMoveToPoint(path, nil, w,y/2);
//        CGPathAddQuadCurveToPoint(path, nil, w+x/4, -yc,w+ x/2, y/2);
//        CGPathMoveToPoint(path, nil, w+x/2,y/2);
//        CGPathAddQuadCurveToPoint(path, nil, w+3*x/4, y+yc, w+x, y/2);
//        CGContextAddPath(context, path);
//        CGContextDrawPath(context, kCGPathStroke);
//        w+=x;
//    }
//}

@end
