//
//  CountDownCircle.m
//  SimpleCircularCountDownAnimation
//
//  Created by mpogra on 22/11/16.
//  Copyright © 2016 Aripra Infotech Pvt Ltd. All rights reserved.
//

#import "CountDownCircleView.h"

@implementation CountDownCircleView

 - (void) awakeFromNib {
    _secondsDigit = -1;
     
 }
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    int cornerRadious = 130;
    NSRect r = self.bounds;
    if(_secondsDigit > 0){
        NSString *strToUse = [@"" stringByAppendingFormat:@"%ld",_secondsDigit ];
        NSMutableDictionary * textAttributes = [@{
                                                  NSForegroundColorAttributeName : [NSColor whiteColor]
                                                  } mutableCopy];
        CGFloat cachedTextSize = 75;
        
        
        textAttributes[NSFontAttributeName] = [[NSFontManager  sharedFontManager] fontWithFamily:@"Helvetica"   traits:NSBoldFontMask weight:5 size:cachedTextSize];
        
        [[NSColor colorWithDeviceRed:0 green:0.0 blue:0 alpha:0.5]set];
        
        NSBezierPath * bgPath = [NSBezierPath bezierPathWithRoundedRect: r xRadius: cornerRadious yRadius: cornerRadious];
        [bgPath fill];
        
        r.size.width -= 1.0;
        r.size.height -= 1.0;
        bgPath = [NSBezierPath bezierPathWithRoundedRect: r xRadius: cornerRadious yRadius: cornerRadious];
        NSAffineTransform * t = [NSAffineTransform transform];
        [t translateXBy: 0.5 yBy: 0.5];
        [bgPath transformUsingAffineTransform: t];
        
        [[NSColor clearColor] set];
        [bgPath stroke];
        
        
        // NSPoint viewCenter = CGPointMake((self.frame.origin.x + (self.frame.size.width / 2)),    (self.frame.origin.y + (self.frame.size.height / 2)));
        NSPoint viewCenter = { 75,75 };
        
        NSBezierPath * path = [NSBezierPath bezierPath];
        
        CGFloat newSeconds = (_maxSeconds+1) - (_secondsDigit);
        
        CGFloat progressCircleStartAngle = 90;
        //pseudo math, seems to work:
        CGFloat progressCircleEndAngle = 360+(360-((newSeconds/(self.maxSeconds))*360))-270;
        progressCircleEndAngle = (progressCircleEndAngle > 360) ? progressCircleEndAngle-360 : progressCircleEndAngle;
        progressCircleEndAngle = (newSeconds == _maxSeconds) ? 90.001f : progressCircleEndAngle;
        
         NSLog(@"%ld/%ld progressCircleStartAngle=%f and progressCircleEndAngle = %f ",(long)newSeconds,(long)self.maxSeconds,progressCircleStartAngle,progressCircleEndAngle);
        
        [path appendBezierPathWithArcWithCenter: viewCenter
                                         radius: cornerRadious/2
                                     startAngle: progressCircleStartAngle
                                       endAngle: progressCircleEndAngle
         clockwise:YES];
        
        [[NSColor redColor] set];
        [path stroke];
        
        
        
        if(strToUse && [strToUse length] > 0 && ![strToUse isEqualToString:@"0"]){
            NSSize s = [strToUse sizeWithAttributes: textAttributes];
            NSRect titleFrame = self.bounds;
            titleFrame.size.width = s.width;
            titleFrame.size.height = s.height;
            
            titleFrame.origin.x = (self.bounds.size.width-s.width)/2;
            titleFrame.origin.y = (self.bounds.size.height-s.height) / 2.0;
            [strToUse  drawWithRect: titleFrame options: (NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin) attributes: textAttributes];
        }
    }
}
- (void) setSecondsDigit:(NSInteger)secondsDigit{
    _secondsDigit = secondsDigit;
    [self setNeedsDisplay:YES];
}
@end


