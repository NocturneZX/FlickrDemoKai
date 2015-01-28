//
//  CustomFlowLayout.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/17/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;



@end
