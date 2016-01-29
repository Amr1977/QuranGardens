//
//  SuraView.m
//  QuranGardens
//
//  Created by Amr Lotfy on 1/29/16.
//  Copyright © 2016 Amr Lotfy. All rights reserved.
//

#import "SuraView.h"
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

@implementation SuraView

- (CGFloat)cornerScaleFactor {
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}
- (CGFloat)cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}
- (CGFloat)cornerOffset {
    return [self cornerRadius] / 3.0;
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *roundedRect =
    [UIBezierPath bezierPathWithRoundedRect:self.bounds
                               cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor greenColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

@end
