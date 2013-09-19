//
//  CHFeedItemCell.h
//  Couchy
//
//  Created by Jesse Montrose on 8/8/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHVideoRef.h"

@interface CHFeedItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timerLabelview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelView;
@property (weak, nonatomic) IBOutlet UIImageView *stillImageView;

@property (strong, nonatomic) CHVideoRef *videoRef;

@end
