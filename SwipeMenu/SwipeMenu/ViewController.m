//
//  ViewController.m
//  SwipeMenu
//
//  Created by Michael on 02/12/14.
//  Copyright (c) 2014 Michael Frick. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"

@interface ViewController ()
@property (nonatomic, strong)   UIButton *buttonLeft;
@property (nonatomic)           bool open;
@property (nonatomic)           CGFloat startLocation;
@property (strong, nonatomic)   MenuView *menuView;
@property (strong, nonatomic)   UIView *darker;
@property (strong, nonatomic)   UIView *board;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *settings = [[UIImageView alloc]initWithFrame: CGRectMake(0,0,40,40)];
    settings.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithCustomView:settings];
    self.navigationItem.leftBarButtonItem = menu;
    
    self.buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0,0,settings.frame.size.height,settings.frame.size.height)];
    [self.buttonLeft addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    
    [settings addSubview:self.buttonLeft];
}

- (void) openSettings {
    self.buttonLeft.userInteractionEnabled = false;
    
    if(self.open) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:(UIViewAnimationOptions)UIViewAnimationCurveEaseInOut
                         animations:^{
                             self.darker.alpha = 0.0;
                             self.menuView.center = CGPointMake(self.menuView.center.x - self.view.frame.size.width/1.1, self.menuView.center.y);
                         }
                         completion:^(BOOL finished){
                             [self.menuView removeFromSuperview];
                             [self.darker removeFromSuperview];
                             [self.board removeFromSuperview];
                             self.open = false;
                             self.buttonLeft.userInteractionEnabled = true;
                         }];
    }
    else {
        self.menuView = [[MenuView alloc] initWithSize:CGPointMake(self.view.frame.size.width/1.1, self.view.frame.size.height)];
        
        self.darker = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.darker.backgroundColor = [UIColor blackColor];
        self.darker.alpha = 0.0;
        [self.view addSubview:self.darker];
        
        self.board = [[UIView alloc]initWithFrame:CGRectMake(- self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self.board];
        
        UIPanGestureRecognizer * swipeleft = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [self.view addGestureRecognizer:swipeleft];
        
        [self.board addSubview:self.menuView];
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:(UIViewAnimationOptions)UIViewAnimationCurveEaseInOut
                         animations:^{
                             self.darker.alpha = 0.4;
                             self.board.center = CGPointMake(self.board.center.x + self.board.frame.size.width, self.board.center.y);
                         }
                         completion:^(BOOL finished){
                             self.open = true;
                             self.buttonLeft.userInteractionEnabled = true;
                         }];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startLocation = [sender locationInView:self.view].x;
    }
 
    if(self.board.frame.origin.x <= 0) {
        CGFloat xAxis = -(self.board.frame.size.width - [sender locationInView:self.view].x) +self.board.frame.size.width - self.startLocation;
        self.board.frame = CGRectMake( xAxis , self.board.frame.origin.y, self.board.frame.size.width, self.board.frame.size.height);
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if([sender locationInView:self.view].x <= 200 && self.open) {
            [self openSettings];
        }
    }
}


@end
