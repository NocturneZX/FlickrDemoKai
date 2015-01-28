//
//  GNParticleView.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/21/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "GNParticleView.h"


// PARTICLE SETTINGS //
static float birthRateGN = 0;
static float lifetimeGN = 5;
static float lifetimeRangeGN  = 10;
static float velocityGN  = 15;
static float velocityRangeGN = 100;

static float xAccelerationGN = 0.0;
static float yAccelerationGN = -0.05;
static float zAccelerationGN = 0.0;

static float redRangeGN = 0.15;
static float redSpeedGN = 0.25;

static float greenRangeGN = 1.0;
static float greenSpeedGN = 0.75;

static float blueRangeGN = 0.35;
static float blueSpeedGN = 0.25;

static float emissionRangeGN = M_PI * 2;
static float emissionLatitudeGN = 0.0;
static float emissionLongitudeGN = 0.0;

static float alphaRangeGN = 1.0;
static float alphaSpeedGN = 1.0;

static float scaleGN = 0.17;
static float scaleRangeGN = 0.0;
static float scaleSpeedGN = 0.0;

static float spinGN = 0.0;
static float spinRangeGN = M_PI * 4;
// //
@implementation GNParticleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

+ (Class) layerClass
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}

-(void)awakeFromNib{
    
    /* At the begining there is no particle dispersion. GN Particles are decayed baryons and are responsive to an unspecified machine-producible interactive force. Another special ability of GN Particles is the manipulation of weight - specifically, the pull of gravity on mass. As a result of this, GN Particles can either increase or decrease the weight of an object.In the Universal Century, these are called Minovsky particles. First time using CAEmitterLayer and Particles*/
    
    //Create a reference and an instance of CAEmitterLayer
    emitterLayerGN = (CAEmitterLayer *)self.layer;
    emitterLayerGN = [CAEmitterLayer layer];
    
    //Set the bounds to be full screen
    emitterLayerGN.frame = self.bounds;
    emitterLayerGN.bounds = CGRectMake(-150, -300, self.frame.size.width, self.frame.size.height);
    
    //Place it at the center
    emitterLayerGN.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2); // 2
    
    //Set the background color to be clear to blend with collection view
    emitterLayerGN.backgroundColor = [[UIColor clearColor] CGColor];
    
    //Size of Emitter
    emitterLayerGN.emitterSize = CGSizeMake(200, 200);
    
    //Add it as sublayer of the main view's layer
    [self.layer addSublayer:emitterLayerGN];
    
    //------------------------GN EMITTER CELL-----------------------------

    //Create Cell
    CAEmitterCell * gnParticleCell = [CAEmitterCell emitterCell];
    
    //Name is necessary to access this cell by Key-Value-Coding (KVC)
    gnParticleCell.name = @"GNParticle";
    
    //Image used for the cell
    gnParticleCell.contents = (id) [[UIImage imageNamed:@"star.png"] CGImage];
    
    
    // Temporal Attributes
    gnParticleCell.birthRate = birthRateGN;
    gnParticleCell.lifetime = lifetimeGN;
    gnParticleCell.lifetimeRange = lifetimeRangeGN;
    
    gnParticleCell.scaleSpeed = scaleSpeedGN;
    
    gnParticleCell.velocity = velocityGN;
    gnParticleCell.velocityRange = velocityRangeGN;
    
    gnParticleCell.xAcceleration = xAccelerationGN;
    gnParticleCell.yAcceleration = yAccelerationGN;
    gnParticleCell.zAcceleration = zAccelerationGN;
    
    // Visual Attributes
    gnParticleCell.color = [UIColor colorWithRed:32.0/255.0
                                            green:210.0/255.0
                                            blue:190.0/255.0
                                            alpha:1.0].CGColor;
    gnParticleCell.scale = (CGFloat)scaleGN;
    gnParticleCell.scaleRange = (CGFloat)scaleRangeGN;
    
    gnParticleCell.redRange = redRangeGN;
    gnParticleCell.redSpeed = redSpeedGN;
    gnParticleCell.greenRange = greenRangeGN;
    gnParticleCell.greenSpeed = greenSpeedGN;
    gnParticleCell.blueRange = blueRangeGN;
    gnParticleCell.blueSpeed = blueSpeedGN;
    
    gnParticleCell.alphaRange = alphaRangeGN;
    gnParticleCell.alphaSpeed = alphaSpeedGN;
    
    // Motion Attributes
    gnParticleCell.spin = spinGN;
    gnParticleCell.spinRange = spinRangeGN;
    gnParticleCell.emissionLatitude = emissionLatitudeGN;
    gnParticleCell.emissionLongitude = emissionLongitudeGN;
    gnParticleCell.emissionRange = emissionRangeGN;
    
    emitterLayerGN.emitterCells = @[gnParticleCell];
    

}

-(void)beginGNParticleDispersal
{
    //Access the property with this key path format: @"emitterCells.<name>.<property>"
    [emitterLayerGN setValue:[NSNumber numberWithInt:200] forKeyPath:@"emitterCells.GNParticle.birthRate"];
}


@end
