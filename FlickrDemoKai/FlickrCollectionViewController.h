//
//  FlickrCollectionViewController.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/15/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNParticleView.h"

@interface FlickrCollectionViewController : UICollectionViewController{
    IBOutlet GNParticleView *gnView;
    
}


//UIMotionEffect
-(void)setGundamGalleryInMotion: (UIImageView *)background;


// Mode Switch
-(IBAction)SwitchMode:(id)sender;

@end
