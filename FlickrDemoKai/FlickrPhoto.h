//
//  FlickrPhoto.h
//  FlickrDemo
//
//  Created by Julio Reyes on 7/13/14.
//  Copyright (c) 2014 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject

@property NSString *filckrphotoID;
@property NSString *filckrphotoTitle;
@property NSURL  *filckrphotoImageURL;
@property NSURL  *filckrphotoThumbnailImageURL;
@property NSString *filckrphotoAuthor;

- (instancetype)initWithFlickrPhoto:(NSString *)aFlickrPhotoID
               phototitle:(NSString *)aFlickrPhotoTitle
               photoimage:(NSURL *)aFlickrPhotoImage
               photothumb:(NSURL *)aFlickrPhotoThumb
              photoauthor:(NSString *)theFlickrPhotoAuthor;

//- (id)initWithDictionary:(NSDictionary *)dict;

@end
