//
//  GNParticleView.h
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/21/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GNParticleView : UIView{
    CAEmitterLayer *emitterLayerGN;
}

-(void)beginGNParticleDispersal;

@end
