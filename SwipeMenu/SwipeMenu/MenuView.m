//
//  MenuView.m
//  SwipeMenu
//
//  Created by Michael on 02/12/14.
//  Copyright (c) 2014 Michael Frick. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithSize:(CGPoint)size {
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        //background view
        UIView *menu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.x, size.y)];
        menu.backgroundColor = [UIColor whiteColor];
        menu.alpha = 1.0;
        [self addSubview:menu];
        
        menu.layer.shadowColor = [[UIColor blackColor] CGColor];
        menu.layer.shadowOffset = CGSizeMake(10.0f,0.0f);
        menu.layer.shadowOpacity = 0.3f;
        menu.layer.shadowRadius = 4.0f;
    }
    return self;
}

@end
