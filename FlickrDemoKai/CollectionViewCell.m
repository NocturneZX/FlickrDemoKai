//
//  CollectionViewCell.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/15/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    
    // reset image property of imageView for reuse
    self.imageView.image = nil;
    
    // update frame position of subviews
    self.imageView.frame = self.contentView.bounds;

}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    // Apply image masking in the cell
    self.layer.cornerRadius = 75;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithRed:32.0/255.0 green:210.0/255.0 blue:190.0/255.0 alpha:0.9].CGColor;
    self.layer.masksToBounds = YES;
    
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:75].CGPath;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.sublayerTransform = CATransform3DIdentity;
    
    self.layer.shouldRasterize = YES;
}

@end
