//
//  FlickrDataDownloader.h
//  FlickrDemo
//
//  Created by Julio Reyes on 7/12/14.
//  Copyright (c) 2014 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FlickrPhoto.h"


@protocol FlickrDataDownloaderDelegate
    - (void) FlickrDataDownloaderDidComplete: (NSArray *)resultingdata;
@end

//
@interface FlickrDataDownloader : NSObject{
    NSUInteger currentpage;
}

@property NSUInteger currentpage;

// Singleton
+(instancetype)sharedInstance;

@property id<FlickrDataDownloaderDelegate>delegate;
    - (void) getArrayOfPhotoObjectsforTheSearchTerm: (NSString *)searchTerm;

@end
