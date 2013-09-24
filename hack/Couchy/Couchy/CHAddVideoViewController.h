//
//  CHAddVideoViewController.h
//  Couchy
//
//  Created by Tyson White on 9/23/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHFeed.h"

@interface CHAddVideoViewController : UITableViewController<UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *feeds;

@end
