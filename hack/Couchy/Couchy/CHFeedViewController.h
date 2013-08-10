//
//  CHFeedViewController.h
//  Couchy
//
//  Created by Jesse Montrose on 8/8/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHFeedViewController : UITableViewController

@property (readwrite, strong, nonatomic) dispatch_queue_t downloadQueue;
@property (strong, nonatomic) NSMutableArray *feedItems;

@end
