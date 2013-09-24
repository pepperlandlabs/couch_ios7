//
//  CHFeedViewController.m
//  Couchy
//
//  Created by Jesse Montrose on 8/8/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "Flurry.h"
#import "CHVideoRef.h"
#import "CHFeedViewController.h"
#import "CHFeed.h"

@interface CHFeedViewController ()

@end

@implementation CHFeedViewController
@synthesize moviePlayer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.downloadQueue = dispatch_queue_create("org.ninth.app.downloadQueue", NULL);
    [Flurry logEvent:@"queue_view" withParameters:@{@"queue":@"default"}];

    self.feed = [[CHFeed alloc] initWithURL:[NSURL URLWithString:@"http://pepperlandlabs.com/couch/couch.json"]];
    [self.feed downloadItemsWithsuccess: ^{
        [self.tableView reloadData];
    } failure:^{
        NSLog(@"failed");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.feed.videos.count;
    } else {
        if (self.feed.videos.count == 1) {
            return 1;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VIDEO_CELL";
    CHFeedItemCell *cell = (CHFeedItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CHVideoRef *videoRef = self.feed.videos[indexPath.row];
    cell.videoRef = videoRef;
    cell.delegate = self;

    return cell;
}

- (void)playMovie
{
    // Just here to keep the old behavior working
    [self playVideoURL:[NSURL URLWithString:@"http://pepperlandlabs.com/couch/Shugo2.m4v"]];
}

- (void)playVideoURL:(NSURL *)url
{
    NSLog(@"playVideoURL: %@", url);
    // NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         // pathForResource:@"Shugo" ofType:@"m4v"]];
    moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}


@end
