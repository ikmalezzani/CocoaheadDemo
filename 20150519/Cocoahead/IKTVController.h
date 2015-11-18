//
//  IKTVController.h
//  Cocoahead
//
//  Created by Ikmal Ezzani on 10/17/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IKTVController;
@protocol IKTVControllerDelegate <NSObject>
- (void)controllerMoveToPoint:(CGPoint)location;
- (void)controllerDidConnect:(IKTVController *)controller;
@end

@interface IKTVController : NSObject
@property (nonatomic, assign)       id<IKTVControllerDelegate>  delegate;
@property (nonatomic, readonly)     NSString                    *debugGravityCoordinate;

+ (instancetype)controller;
/*!
 @brief Attach a view to start receiving delegate callback
 */
+ (void)addToViewController:(UIViewController<IKTVControllerDelegate> *)view;
@end
