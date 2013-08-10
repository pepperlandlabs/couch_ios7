//
//  CHVideoRef.h
//  Couchy
//
//  Created by Jesse Montrose on 8/9/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHVideoRef : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *stillImageURL;
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) NSNumber *duration;

+ (CHVideoRef *) videoRefWithData:(NSDictionary *)data;

@end
