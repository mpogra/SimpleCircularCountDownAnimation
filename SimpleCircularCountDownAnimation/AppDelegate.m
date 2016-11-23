//
//  AppDelegate.m
//  SimpleCircularCountDownAnimation
//
//  Created by mpogra on 22/11/16.
//  Copyright © 2016 Aripra Infotech Pvt Ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.countDownView.maxSeconds = 5;
        self.countDownView.secondsDigit = 5;
        [self.countDownView setNeedsDisplay:YES];
    });
    
    

}
- (IBAction)startButtonPressed:(id)sender {
    toSetSeconds = 0;
    if(tickTimer)
        [tickTimer invalidate];
    self.countDownView.maxSeconds = 5;
    self.countDownView.secondsDigit = toSetSeconds;
    tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}
- (void)tick
{
    if(toSetSeconds > self.countDownView.maxSeconds)
    {
        [tickTimer invalidate];
        return;
    }
    if(self.countDownView)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
           
            
            self.countDownView.secondsDigit = self.countDownView.maxSeconds - toSetSeconds;
           toSetSeconds++;
            
            
        });
        
    }
     
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
