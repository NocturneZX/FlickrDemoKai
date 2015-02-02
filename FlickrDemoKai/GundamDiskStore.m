//
//  GundamDiskStore.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 2/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "FlickrPhoto.h"
#import "PhotoDatabase.h"
#import "GundamDiskStore.h"

@implementation GundamDiskStore
@synthesize filckrPhotoFilePath = _filckrPhotoFilePath;
@synthesize photoData = _photoData;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

-(instancetype)initWithPhotoData:(NSString *)photoPath{
    if (self == [super init]) {
        _filckrPhotoFilePath = [_filckrPhotoFilePath copy];
    }
    return self;
}
-(instancetype)initWithID:(NSString *)aFlickrPhotoID
               phototitle:(NSString *)aFlickrPhotoTitle
               photoimage:(NSURL *)aFlickrPhotoImage
               photothumb:(NSURL *)aFlickrPhotoThumb
              photoauthor:(NSString *)theFlickrPhotoAuthor{
    if ((self = [super init])) {
        _photoData = [[FlickrPhoto alloc]initWithFlickrPhoto:aFlickrPhotoID phototitle:aFlickrPhotoTitle photoimage:aFlickrPhotoImage photothumb:aFlickrPhotoThumb photoauthor:theFlickrPhotoAuthor];
    }
    
    return self;
}
- (BOOL)createDataPath {
    
    if (_filckrPhotoFilePath == nil) {
        self.filckrPhotoFilePath = [PhotoDatabase nextPhotoPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_filckrPhotoFilePath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}

- (void)savePhotoData{
    
}
- (void)saveImages{
    
}
- (void)deletePhotoData{
    
}

@end
