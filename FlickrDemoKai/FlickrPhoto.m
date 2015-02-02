//
//  FlickrPhoto.m
//  FlickrDemo
//
//  Created by Julio Reyes on 7/13/14.
//  Copyright (c) 2014 Julio Reyes. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

#pragma mark - NSCoding Methods

#define gFlickrIDKey            @"ID"
#define gFlickrAuthorKey        @"Author"
#define gFlickrTitleKey         @"Title"
#define gFlickrThumbImageKey    @"ThumbImage"
#define gFlickrImageKey         @"Image"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_filckrphotoID forKey:gFlickrIDKey];
    [encoder encodeObject:_filckrphotoAuthor forKey:gFlickrAuthorKey];
    [encoder encodeObject:_filckrphotoTitle forKey:gFlickrTitleKey];
    [encoder encodeObject:_filckrphotoThumbnailImageURL forKey:gFlickrThumbImageKey];
    [encoder encodeObject:_filckrphotoImageURL forKey:gFlickrImageKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *ID = [decoder decodeObjectForKey:gFlickrIDKey];
    NSString *Author = [decoder decodeObjectForKey:gFlickrAuthorKey];
    NSString *Title = [decoder decodeObjectForKey:gFlickrTitleKey];
    NSURL *ThumbImageURL = [decoder decodeObjectForKey:gFlickrThumbImageKey];
    NSURL *ImageURL = [decoder decodeObjectForKey:gFlickrImageKey];

    return [self initWithFlickrPhoto:ID phototitle:Title photoimage:ImageURL photothumb:ThumbImageURL photoauthor:Author];
}
#pragma mark - Init Methods
- (instancetype)initWithFlickrPhoto:(NSString *)aFlickrPhotoID
               phototitle:(NSString *)aFlickrPhotoTitle
               photoimage:(NSURL *)aFlickrPhotoImage
               photothumb:(NSURL *)aFlickrPhotoThumb
              photoauthor:(NSString *)theFlickrPhotoAuthor
{
    if ((self = [super init])) {
        self.filckrphotoID = aFlickrPhotoID;
        self.filckrphotoTitle = aFlickrPhotoTitle;
        self.filckrphotoImageURL = aFlickrPhotoImage;
        self.filckrphotoThumbnailImageURL = aFlickrPhotoThumb;
        self.filckrphotoAuthor = theFlickrPhotoAuthor;
    }
    
    return self;
}

@end
