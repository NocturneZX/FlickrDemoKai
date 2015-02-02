//
//  GundamDiskStore.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 2/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PhotoDatabase.h"

@class FlickrPhoto;

@interface GundamDiskStore : NSObject{
    FlickrPhoto *photoData;
    UIImage *_thumbImage;
    UIImage *_fullImage;
    NSString *filckrPhotoFilePath;
}
@property (retain) FlickrPhoto *photoData;
@property (copy) NSString *filckrPhotoFilePath;
@property (retain) UIImage *thumbImage;
@property (retain) UIImage *fullImage;

-(id)init;
-(instancetype)initWithPhotoData:(NSString *)photoPath;
-(instancetype)initWithID:(NSString *)aFlickrPhotoID
                  phototitle:(NSString *)aFlickrPhotoTitle
                  photoimage:(NSURL *)aFlickrPhotoImage
                  photothumb:(NSURL *)aFlickrPhotoThumb
              photoauthor:(NSString *)theFlickrPhotoAuthor;
- (void)savePhotoData;
- (void)saveImages;
- (void)deletePhotoData;

@end
