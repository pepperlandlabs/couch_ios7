//
//  CHIntroViewController.h
//  Couchy
//
//  Created by Tyson White on 9/26/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHIntroViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
