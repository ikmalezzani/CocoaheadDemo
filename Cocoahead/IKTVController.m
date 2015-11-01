//
//  IKTVController.m
//  Cocoahead
//
//  Created by Ikmal Ezzani on 10/17/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#import "IKTVController.h"
#import <GameController/GameController.h>

@interface IKTVController()
@property (nonatomic, strong) GCController  *controller;
@property (nonatomic, assign) CGSize        frameSize;
@end

@implementation IKTVController
+ (instancetype)controller
{
    static dispatch_once_t onceToken;
    static IKTVController *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IKTVController alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:GCControllerDidConnectNotification object:nil];
    }
    return self;
}

- (void)notificationHandler:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GCControllerDidConnectNotification]) {
        if ([self.delegate respondsToSelector:@selector(controllerDidConnect:)]) {
            [self.delegate controllerDidConnect:self];
        }
        
        self.controller = [[GCController controllers] objectAtIndex:0];
        __block IKTVController *this = self;
        
        [self.controller.motion setValueChangedHandler:^(GCMotion *motion) {
            _debugGravityCoordinate = [NSString stringWithFormat:@"x:%f y:%f z:%f", motion.gravity.x, motion.gravity.y, motion.gravity.z];

            // normalizer was meant to make the number positive
            CGFloat normalizer = 1.0f;
            CGFloat y = (motion.gravity.y / motion.gravity.z) * -1;
            CGFloat yPosition = (self.frameSize.height * ((normalizer + y) / 2));
            CGFloat x = (motion.gravity.x / motion.gravity.z) * -1;
            CGFloat xPosition = (self.frameSize.width * (normalizer + x)) / 2;
            
            CGPoint pointPosition = CGPointMake(xPosition, yPosition);
            if ([this.delegate respondsToSelector:@selector(controllerMoveToPoint:)]) {
                [this.delegate controllerMoveToPoint:pointPosition];
            }
        }];
    }
}

+ (void)addToViewController:(UIViewController<IKTVControllerDelegate> *)viewController;
{
    IKTVController *controller = [IKTVController controller];
    [controller addToViewController:viewController];
}

- (void)addToViewController:(UIViewController<IKTVControllerDelegate> *)viewController;
{
    self.delegate = viewController;
    self.frameSize = viewController.view.frame.size;
}
@end
