//
//  CHFeed.m
//  Couchy
//
//  Created by Tyson White on 9/23/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHFeed.h"

@implementation CHFeed

- (CHFeed *)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.downloadQueue = dispatch_queue_create("org.ninth.app.downloadQueue", NULL);
        self.url = url;
    }
    return self;
}

-(void)downloadItemsWithsuccess:(void(^)(void))successBlock
                        failure:(void(^)(void))failureBlock
{
    // download json in the background
    [self loadURLWithFailoverToCache:self.url
                             success:^(NSData *data) {
                                 NSError *error;
                                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                 if (!response) {
                                     NSLog(@"JSON parse failed: %@", error);
                                     NSString *raw = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                     NSLog(@"DATA: %@", raw );
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
                                     self.videos = newFeedItems;
                                     if (successBlock) {
                                         successBlock();
                                     }
                                 }
                             } failure:^{
                                 if (failureBlock) {
                                     failureBlock();
                                 }
                                 NSLog(@"items fetch failed");
                                 
                             }];
}

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
