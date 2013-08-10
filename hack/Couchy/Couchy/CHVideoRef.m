//
//  CHVideoRef.m
//  Couchy
//
//  Created by Jesse Montrose on 8/9/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHVideoRef.h"

@implementation CHVideoRef

+ (CHVideoRef *) videoRefWithData:(NSDictionary *)data
{
    CHVideoRef *videoRef = [[CHVideoRef alloc] init];
    videoRef.title = data[@"title"];
    videoRef.stillImageURL = [NSURL URLWithString:data[@"still_image_url"]];
    videoRef.videoURL = [NSURL URLWithString:data[@"video_url"]];
    //videoRef.duration = [NSNumber numberWithInt:data[@"duration"]];
    return videoRef;
}

@end
