//
//  CHFeedViewController.m
//  Couchy
//
//  Created by Jesse Montrose on 8/8/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHVideoRef.h"
#import "CHFeedItemCell.h"
#import "CHFeedViewController.h"

@interface CHFeedViewController ()

@end

@implementation CHFeedViewController

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
    
    self.downloadQueue = dispatch_queue_create("org.ninth.app.downloadQueue", NULL);
    [self downloadItems];
}

- (void)downloadItems
{
    // download json in the background
    [self loadURLWithFailoverToCache:[NSURL URLWithString:@"http://spine.com/couch.json"]
        success:^(NSData *data) {
           NSError *error;
           NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
           if (!response) {
               NSLog(@"JSON parse failed: %@", error);
           } else {
               NSDictionary *result = response[@"result"];
               NSArray *videos = result[@"videos"];
               NSMutableArray *newFeedItems = [@[] mutableCopy];
               // Might want to parse and load these in the background too
               for (NSDictionary *videoData in videos) {
                   CHVideoRef *videoRef = [CHVideoRef videoRefWithData:videoData];
                   if (!videoRef) {
                       NSLog(@"failed videoRef: %@", videoData);
                   } else {
                       [newFeedItems addObject:videoRef];
                   }
               }
               self.feedItems = newFeedItems;
               [self.tableView reloadData];
           }
       } failure:^{
           NSLog(@"items fetch failed");
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
    return self.feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VIDEO_CELL";
    CHFeedItemCell *cell = (CHFeedItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CHVideoRef *videoRef = self.feedItems[indexPath.row];
    cell.titleLabelView.text = videoRef.title;
    [videoRef loadImageIntoView:cell.stillImageView];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(NSURL *)cacheURLForURL:(NSURL *)url
{
    NSUInteger urlHash = [url hash];
    NSURL *cachesDir = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                                               inDomains:NSUserDomainMask] lastObject];
    NSString *cacheFile = [NSString stringWithFormat:@"%d.%@", urlHash, url.pathExtension];
    NSURL *cachePath = [cachesDir URLByAppendingPathComponent:cacheFile];
    return cachePath;
}

-(NSData *)dataFromCache:(NSURL *)url
{
    NSURL *cacheFile = [self cacheURLForURL:url];
    NSError *error;
    if ([cacheFile checkResourceIsReachableAndReturnError:&error]) {
        NSData *data = [NSData dataWithContentsOfURL:cacheFile];
        return data;
    }
    return nil;
}

-(void)loadURLWithFailoverToCache:(NSURL *)url
             success:(void(^)(NSData *data))successBlock
             failure:(void(^)(void))failureBlock
{
    dispatch_async(self.downloadQueue, ^{

        // Always try to fetch
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (!data) {
            // Network failed, how about local cache?
            data = [self dataFromCache:url];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!data) {
                failureBlock();
            } else {
                // Save the data to disk
                if (![data writeToURL:[self cacheURLForURL:url] atomically:YES]) {
                    NSLog(@"failed to write cache file");
                }
                successBlock(data);
            }
        });
    });


}


@end
