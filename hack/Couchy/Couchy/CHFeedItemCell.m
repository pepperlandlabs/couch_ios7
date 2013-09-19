//
//  CHFeedItemCell.m
//  Couchy
//
//  Created by Jesse Montrose on 8/8/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHFeedItemCell.h"

@implementation CHFeedItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVideoRef:(CHVideoRef *)videoRef
{
    _videoRef = videoRef;
    self.titleLabelView.text = videoRef.title;
    self.timerLabelview.text = videoRef.durationString;
    [videoRef loadImageIntoView:self.stillImageView];
}

- (IBAction)playPressed:(id)sender {
    NSLog(@"playPressed, videoURL=%@", self.videoRef.videoURL);
    [self.delegate playVideoURL:self.videoRef.videoURL];
}
@end
