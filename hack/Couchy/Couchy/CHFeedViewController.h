//
//  CHFeedViewController.h
//  Couchy
//
//  Created by Jesse Montrose on 8/8/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CHFeedViewController : UITableViewController
{
    MPMoviePlayerController *moviePlayer;
}

@property (readwrite, strong, nonatomic) dispatch_queue_t downloadQueue;
@property (strong, nonatomic) NSMutableArray *feedItems;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
-(IBAction) playMovie;

@end
