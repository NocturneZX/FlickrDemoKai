//
//  PhotoDatabase.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 2/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "PhotoDatabase.h"
#import "GundamDiskStore.h"

@implementation PhotoDatabase
+ (NSString *)getPrivatePhotosDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Photo Documents"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    return documentsDirectory;
    
}
+ (NSMutableArray *)loadPhotoData{
    // Get private docs directory
    NSString *documentsDirectory = [PhotoDatabase getPrivatePhotosDir];
    NSLog(@"Loading photos from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create FlickrPhoto for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"photo" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            GundamDiskStore *photo = [[GundamDiskStore alloc]initWithPhotoData:fullPath];
            [retval addObject:photo];
        }
    }
    
    return retval;
}

+ (NSString *)nextPhotoPath{
    return nil;
}
@end
