//
//  CollectionViewCell.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/15/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *photoName;
@end
