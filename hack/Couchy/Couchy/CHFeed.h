//
//  CHFeed.h
//  Couchy
//
//  Created by Tyson White on 9/23/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHVideoRef.h"

@interface CHFeed : NSObject

@property (strong, nonatomic) NSMutableArray *videos;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;

@property (readwrite, strong, nonatomic) dispatch_queue_t downloadQueue;

- (CHFeed *)initWithURL:(NSURL *)url;

-(void)loadURLWithFailoverToCache:(NSURL *)url
                          success:(void(^)(NSData *data))successBlock
                          failure:(void(^)(void))failureBlock;
-(void)downloadItemsWithsuccess:(void(^)(void))successBlock
                          failure:(void(^)(void))failureBlock;




@end
