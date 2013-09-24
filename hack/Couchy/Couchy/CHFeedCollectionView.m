//
//  CHFeedCollectionView.m
//  Couchy
//
//  Created by Tyson White on 9/23/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "CHFeedCollectionView.h"
#import "CHVideoRef.h"

@implementation CHFeedCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.feed.videos.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CHVideoRef *video = self.feed.videos[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    if (cell) {
        UITextView *cellTitle = (UITextView *)[cell viewWithTag:101];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:102];

        cellTitle.text = video.title;
        [video loadImageIntoView:imageView];
    }
    return cell;
}


@end
