//
//  FlickrPhoto.h
//  FlickrDemo
//
//  Created by Julio Reyes on 7/13/14.
//  Copyright (c) 2014 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject <NSCoding>

@property (nonatomic, copy) NSString *filckrphotoID;
@property (nonatomic, copy) NSString *filckrphotoTitle;
@property (nonatomic, copy) NSURL  *filckrphotoImageURL;
@property (nonatomic, copy) NSURL  *filckrphotoThumbnailImageURL;
@property (nonatomic, copy) NSString *filckrphotoAuthor;


- (instancetype)initWithFlickrPhoto:(NSString *)aFlickrPhotoID
               phototitle:(NSString *)aFlickrPhotoTitle
               photoimage:(NSURL *)aFlickrPhotoImage
               photothumb:(NSURL *)aFlickrPhotoThumb
              photoauthor:(NSString *)theFlickrPhotoAuthor;



@end
