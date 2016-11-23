//
//  AppDelegate.h
//  SimpleCircularCountDownAnimation
//
//  Created by mpogra on 22/11/16.
//  Copyright © 2016 Aripra Infotech Pvt Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CountDownCircleView.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSInteger toSetSeconds;
    NSTimer *tickTimer;
}
@property (nonatomic,retain) IBOutlet CountDownCircleView *countDownView;
@end

