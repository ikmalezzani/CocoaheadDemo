//
//  ViewController.m
//  Cocoahead
//
//  Created by Ikmal Ezzani on 10/17/15.
//  Copyright © 2015 Mindvalley. All rights reserved.
//

#import "ViewController.h"
#import "IKTVController.h"
#import "Vector.h"

@interface ViewController () <IKTVControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel  *labelDebug;
@property (strong, nonatomic) IBOutlet UILabel  *labelShout;
@property (strong, nonatomic) IBOutlet UIView   *hiddenFrame;
@property (nonatomic, strong) UIView            *pointer;
@property (nonatomic, strong) NSMutableArray    *imageViews;
@property (nonatomic, strong) NSMutableArray    *trashedImageViews;
@property (nonatomic, assign) BOOL              didGrab;
@property (nonatomic, strong) UIImageView       *slidesInHand;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageViews = @[].mutableCopy;
    self.trashedImageViews = @[].mutableCopy;
    [self.labelShout setAlpha:0.0f];
    [IKTVController addToViewController:self];
    
    self.pointer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10.0f, 10.0f)];
    [self.pointer.layer setCornerRadius:CGRectGetHeight(self.pointer.frame)/2];
    [self.pointer setBackgroundColor:[UIColor orangeColor]];
    [self.pointer.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [self.pointer.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [self.pointer.layer setShadowOpacity:0.5f];
    [self.pointer.layer setMasksToBounds:FALSE];
    [self.pointer setCenter:self.view.center];
    [self.view addSubview:self.pointer];
    
    // we are filling with defaults slides
    [self populateSlides];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
}

#pragma mark - Messaging
- (void)shout:(NSString *)message
{
    [self.labelShout setText:message];
    [self.labelShout setAlpha:1.0f];

    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.labelShout setAlpha:0.0f];
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark - Gestures
- (void)swipeGestureHandler:(UISwipeGestureRecognizer *)swipeGesture
{
//    NSLog(@"%@", swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft ? @"left" : @"right");
    switch (swipeGesture.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            [self restackLastSlide];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
//            [self moveTouchedLayerToPoint];
            default:
            break;
    }
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tapGesture
{
    switch (tapGesture.state) {
        case UIGestureRecognizerStateEnded: {
            [self moveTouchedLayerToPoint];
        }
            break;
            default:
            break;
    }
}

#pragma mark - Slide Management
/*!
 @brief Standard method to populate the slides
 */
- (void)populateSlides
{
    for (int i = 1; i <= 13; i++) {
        NSString *index = [NSString stringWithFormat:@"%d", (int) i];
        [self addSlidesWithImage:[UIImage imageNamed:index]];
    }
}

/*!
 @brief To reset to default state
 */
- (void)reset
{
    for (UIImageView *imageView in self.imageViews) {
        [imageView removeFromSuperview];
    }
    
    [self populateSlides];
}

- (void)addSlidesWithImage:(UIImage *)image
{
    [self addSlidesWithImage:image animate:FALSE];
}

/*!
 @brief Add the last slide that went on and animate in
 */
- (void)restackLastSlide
{
    if ([self.trashedImageViews count] == 0) return;
    
    UIImageView *imageView = [self.trashedImageViews lastObject];
    [self addSlidesWithImage:imageView.image animate:TRUE];
    [self.trashedImageViews removeObject:imageView];
    
    [self shout:@"Undo"];
}

/*!
 @brief Add the slides to the screen
 @warning Slides is always added below self.pointer, make sure self.pointer exist before calling this
 */
- (void)addSlidesWithImage:(UIImage *)image animate:(BOOL)shouldAnimate
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.hiddenFrame.frame];
    [imageView setImage:image];
    [imageView setBackgroundColor:[UIColor purpleColor]];
    [self.imageViews addObject:imageView];
    
    // since we reused this, we always re-add underneath pointer
    [self.view insertSubview:imageView belowSubview:self.pointer];
    [imageView setAlpha:0.0f];

    if (shouldAnimate) {
        // add y offset and fade-in
        CGFloat offset = 100.0f;
        [imageView setFrame:CGRectOffset(imageView.frame, 0.0f, -offset)];
        [imageView.layer setShadowColor:[UIColor darkGrayColor].CGColor];
        [imageView.layer setShadowOffset:CGSizeMake(0.0f, 0.3f)];
        [imageView.layer setShadowRadius:10.0f];
        [imageView.layer setShadowOpacity:1.0f];
        [imageView.layer setMasksToBounds:FALSE];
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [imageView setFrame:CGRectOffset(imageView.frame, 0.0f, offset)];
                             [imageView setAlpha:1.0f];
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 // very lazy, yes
                                 [UIView animateWithDuration:0.3
                                                  animations:^{
                                                      [imageView.layer setShadowOpacity:0.0f];
                                                  }];
                             }
                         }];
        
    }
    else {
        [imageView setAlpha:1.0f];
    }
}

/*!
 @brief To move the slides grabbed to destination while animating alpha-out and removing from view-stack
 */
- (void)moveTouchedLayerToPoint
{
    // just keep one last slides
    if ([self.imageViews count] == 1) return;
    
    self.didGrab = [self isGrabbingAtPoint:self.pointer.center];
    if (self.didGrab) {
        CGPoint destination = CGPointAddition(self.pointer.center, CGPointZero);
        
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.slidesInHand setCenter:destination];
                             [self.slidesInHand setAlpha:0.0f];
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [self.trashedImageViews addObject:self.slidesInHand];
                                 [self.imageViews removeObject:self.slidesInHand];
                                 [self.slidesInHand removeFromSuperview];
                             }
                         }];
    }
}

/*!
 @brief To grab a slides at pointer
 @return true when the pointer is touching any point within the slides
 */
- (BOOL)isGrabbingAtPoint:(CGPoint)touchPoint;
{
    // sanity check
    if ([self.imageViews count] == 0) return FALSE;
    
    if (CGRectContainsPoint(self.hiddenFrame.frame, touchPoint)) {
        self.slidesInHand = [self.imageViews objectAtIndex:[self.imageViews count] - 1];
        return TRUE;
    }
    
    return FALSE;
}

#pragma mark - IKTVControllerDelegate
- (void)controllerDidConnect:(IKTVController *)controller
{
    [self shout:@"Connected"];
}

- (void)controllerMoveToPoint:(CGPoint)location
{
    [self.pointer setCenter:location];
    IKTVController *controller = [IKTVController controller];
    [self.labelDebug setText:controller.debugGravityCoordinate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
