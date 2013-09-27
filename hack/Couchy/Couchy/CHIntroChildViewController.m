//
//  CHIntroChildViewController.m
//  Couchy
//
//  Created by Tyson White on 9/26/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHIntroChildViewController.h"

@interface CHIntroChildViewController ()

@end

@implementation CHIntroChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.screenNumber.text = [NSString stringWithFormat:@"Screen #%d", self.index];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
