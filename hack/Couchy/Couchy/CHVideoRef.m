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

- (void)loadImageIntoView:(UIImageView *)view
{
    // Shortcut if we already have it downloaded
    if (self.stillImage) {
        view.image = self.stillImage;
        return;
    }
    
    // use nsoperation instead?
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:self.stillImageURL];
        UIImage *image = [UIImage imageWithData:data];
        self.stillImage = image;
        if (!image) {
            NSLog(@"Failed to load image: %@", self.stillImageURL);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                view.image = self.stillImage;
            });
        }
    });

}

@end
