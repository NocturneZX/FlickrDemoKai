//
//  PhotoDatabase.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 2/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoDatabase : NSObject

+ (NSMutableArray *)loadPhotoData;
+ (NSString *)nextPhotoPath;

@end
