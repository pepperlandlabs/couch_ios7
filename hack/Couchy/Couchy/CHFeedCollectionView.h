//
//  CHFeedCollectionView.h
//  Couchy
//
//  Created by Tyson White on 9/23/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHFeed.h"

@interface CHFeedCollectionView : UICollectionView <UICollectionViewDataSource>

@property (strong, nonatomic) CHFeed *feed;

@end
