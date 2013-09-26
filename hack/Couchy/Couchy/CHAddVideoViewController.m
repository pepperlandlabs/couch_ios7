//
//  CHAddVideoViewController.m
//  Couchy
//
//  Created by Tyson White on 9/23/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHAddVideoViewController.h"
#import "CHFeed.h"
#import "CHFeedCollectionView.h"

@interface CHAddVideoViewController ()

@end

@implementation CHAddVideoViewController

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
    
    self.feeds = [@[] mutableCopy];
    
    CHFeed *feed = [[CHFeed alloc] initWithURL:[NSURL URLWithString:@"http://pepperlandlabs.com/couch/couch.json"]];
    feed.title = @"Recommended";
    [self.feeds addObject:feed];
    [feed downloadItemsWithsuccess: ^{
        [self updateAll];
    } failure:^{
        NSLog(@"failed");
    }];
    
    feed = [[CHFeed alloc] initWithURL:[NSURL URLWithString:@"http://pepperlandlabs.com/couch/couch.json"]];
    feed.title = @"Popular";
    [self.feeds addObject:feed];
    [feed downloadItemsWithsuccess: ^{
        [self updateAll];
    } failure:^{
        NSLog(@"failed");
    }];
}

- (void)updateAll
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CHFeed *feed = self.feeds[indexPath.row];
    UITextView *title = (UITextView *)[cell viewWithTag:101];
    title.text = feed.title;
    
    CHFeedCollectionView *feedCollection = (CHFeedCollectionView *)[cell viewWithTag:102];
    NSLog(@"fc %@", feedCollection);
    feedCollection.feed = feed;
    
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

@end
