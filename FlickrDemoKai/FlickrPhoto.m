//
//  FlickrPhoto.m
//  FlickrDemo
//
//  Created by Julio Reyes on 7/13/14.
//  Copyright (c) 2014 Julio Reyes. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

- (instancetype)initWithFlickrPhoto:(NSString *)aFlickrPhotoID
               phototitle:(NSString *)aFlickrPhotoTitle
               photoimage:(NSURL *)aFlickrPhotoImage
               photothumb:(NSURL *)aFlickrPhotoThumb
              photoauthor:(NSString *)theFlickrPhotoAuthor
{
    if (self) {
        self.filckrphotoID = aFlickrPhotoID;
        self.filckrphotoTitle = aFlickrPhotoTitle;
        self.filckrphotoImageURL = aFlickrPhotoImage;
        self.filckrphotoThumbnailImageURL = aFlickrPhotoThumb;
        self.filckrphotoAuthor = theFlickrPhotoAuthor;
    }
    
    return self;
}

@end
