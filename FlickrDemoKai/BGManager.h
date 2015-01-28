//
//  BGManager.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/22/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGManager : NSObject

- (instancetype)init;
- (void) configureAudioSession;
- (void)configureAudioPlayer;
- (void)playGundamMusic;
- (void)stopGundamMusic;

@end
