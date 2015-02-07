//
//  ViewController.m
//  SwipeMenu
//
//  Created by Michael on 02/12/14.
//  Copyright (c) 2014 Michael Frick. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)   UIButton *buttonLeft;
@property (nonatomic)           CGFloat startLocation;
@property (strong, nonatomic)   MenuView *menuView;
@property (strong, nonatomic)   UIView *darker;
@property (strong, nonatomic)   UIView *board;

@property (strong, nonatomic)   UIScrollView *sliderBase;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(200,110,50,50)];
    self.buttonLeft.backgroundColor = [UIColor whiteColor];
    [self.buttonLeft addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonLeft];
    
    self.sliderBase = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, self.view.frame.size.height)];
    self.sliderBase.pagingEnabled = YES;
    self.sliderBase.bounces = NO;
    self.sliderBase.showsHorizontalScrollIndicator = NO;
    self.sliderBase.backgroundColor = [UIColor clearColor];
    self.sliderBase.delegate = self;
    [self.view addSubview:self.sliderBase];
    
    self.sliderBase.contentSize = CGSizeMake(2*self.sliderBase.frame.size.width, self.sliderBase.frame.size.height-60);
    
    
    UIView *testleft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.sliderBase.frame.size.width, self.sliderBase.frame.size.height)];
    testleft.backgroundColor = [UIColor greenColor];
    [self.sliderBase addSubview:testleft];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(self.sliderBase.contentOffset.x >= 150) {
        self.sliderBase.userInteractionEnabled = NO;
    }
    else {
        self.sliderBase.userInteractionEnabled = YES;
    }
}

- (void) openSettings {
    [self.sliderBase setContentOffset:CGPointMake(0, 0) animated:YES];
    self.sliderBase.userInteractionEnabled = YES;
}


@end
