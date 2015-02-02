//
//  FlickrCollectionViewController.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/15/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <SpriteKit/SpriteKit.h>

#import "FlickrCollectionViewController.h"
#import "FlickrDataDownloader.h"

#import "CustomFlowLayout.h"
#import "CollectionViewCell.h"
#import "BGManager.h"

@interface FlickrCollectionViewController ()  <FlickrDataDownloaderDelegate>{
    NSMutableArray *photosets;
}

@property (nonatomic, strong) NSMutableArray *photosets;
@property FlickrDataDownloader *downloader;

@property (nonatomic) BGManager *gundamPlayer;
@property (nonatomic) UIImageView *backgroundView;

@property (nonatomic, weak) IBOutlet UISegmentedControl *gundamSegControl;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *musicButton;

@end

@implementation FlickrCollectionViewController
@synthesize musicButton = _musicButton;
@synthesize gundamSegControl = _gundamSegControl;
@synthesize backgroundView = _backgroundView;
@synthesize photosets = _photosets;

static NSString * const reuseIdentifier = @"GundamCell";

// Set BOOL toggle for loading more photos in real-time
BOOL isOperating = NO;
BOOL APIActivate = NO;

#define searchQuery @"Gundam"
#define GalleryFrame CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y + 20, self.collectionView.frame.size.width, self.collectionView.frame.size.height)

#define animationDuration 0.5

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    
    //Register the collection view layout
    CustomFlowLayout *currentLayout = [[CustomFlowLayout alloc]init];
    [self.collectionView setCollectionViewLayout:currentLayout animated:YES];
    
    // Set background view
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gnGundam2"]];
    self.backgroundView.frame = GalleryFrame;
    self.backgroundView.alpha = 0.8;
    [gnView addSubview:self.backgroundView];
    
    [self.collectionView setBackgroundView:gnView];
    
    [gnView beginGNParticleDispersal];
    
    
    NSLog(@"Emitter position is %@", NSStringFromCGPoint([gnView.layer anchorPoint]));
    // Do any additional setup after loading the view.
    /* SIMULATOR RUN  */
    
    self.photosets = [[NSMutableArray alloc] init];
    
    if (!APIActivate) {
        NSString *imageExtension = @"jpg";
        NSArray *gundamPaths = [[NSBundle mainBundle] pathsForResourcesOfType:imageExtension
                                                                  inDirectory:nil];
        
        for (int i = 0; i < gundamPaths.count; i++) {
            [_photosets addObject:[UIImage imageNamed:gundamPaths[i]]];
        }
        
        [self.collectionView reloadData];
    }else{
        self.downloader = [FlickrDataDownloader sharedInstance];
        self.downloader.delegate = self;
        // END
        
        // Execute image load.
        [self.downloader getArrayOfPhotoObjectsforTheSearchTerm:searchQuery];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    for(FlickrPhoto *photo in _photosets) {
        photo.filckrphotoImageURL = nil;
        photo.filckrphotoThumbnailImageURL = nil;
        photo.filckrphotoAuthor = nil;
        photo.filckrphotoID = nil;
        photo.filckrphotoTitle = nil;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionViewLayout invalidateLayout];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setGundamGalleryInMotion:_backgroundView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *gundamcell = [collectionView
                                      dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                      forIndexPath:indexPath];
    
    if (!gundamcell) {
        gundamcell = [[CollectionViewCell alloc]init];
    }
    
    [gundamcell prepareForReuse];
    gundamcell.tag = indexPath.row;
    
    // Configure the cell
    if (!APIActivate) {
        // SIMULATOR MODE
        
        // Image Delay Code magic happens herr.
        UIImage *theImage = (self.photosets)[indexPath.row]; //get your image
        int maxDelay = 5;
        int delayInSeconds = arc4random() % maxDelay;
        gundamcell.imageView.image = theImage;
        gundamcell.imageView.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(delayInSeconds * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:animationDuration animations:^{
                
                // Image will appear
                gundamcell.imageView.alpha = 1;
                gundamcell.backgroundView.alpha = 1;
                
                
            }];
        });
        // END
    }else{
        
        // REAL-TIME MODE
        __weak FlickrCollectionViewController *weakSelf = self;

        __block FlickrPhoto *currentPhoto = weakSelf.photosets[indexPath.row];
        

        //Set up images
        // Asynchronously load image. Personally, I like to use the third-party library called SDWebImage. But
        // I wanted to showcase this approach. Also, this has beeen modified for the Collection View.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *imgData = [NSData dataWithContentsOfURL:currentPhoto.filckrphotoThumbnailImageURL];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    gundamcell.imageView.image = image;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                            CollectionViewCell *updateCell = (CollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                            updateCell.imageView.image = image;
                        }
                    });// end dispatch_async(dispatch_get_main_queue())
                }
            }
            
        });// end dispatch_async(dispatch_get_global_queue())
        
        //END
    }

    return gundamcell;
}
#pragma mark - Interface setups
-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;;
}

#pragma mark <UICollectionViewDelegate>
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView 
                    shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView 
                    shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, 
        and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView  
                    shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView 
                    canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath 
                    withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView 
                    performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath 
                    withSender:(id)sender {
	
}
*/

#pragma mark - Flickr API Delegate Methods
-(void)FlickrDataDownloaderDidComplete:(NSArray *)resultingdata{
    if (self.photosets.count == 0) {
   
            [self.photosets addObjectsFromArray:resultingdata];
[self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
    }else{
        [self.collectionView performBatchUpdates:^{
            CustomFlowLayout *layout = (CustomFlowLayout *)self.collectionView.collectionViewLayout;
            
            int resultsSize = (int)resultingdata.count;
            [self.photosets addObjectsFromArray:resultingdata];
            NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
            
            for (int i = resultsSize; i < resultsSize + resultingdata.count; i++){
                [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            [self.collectionView.collectionViewLayout invalidateLayout];
            [self.collectionView setCollectionViewLayout:layout animated:YES];
            [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
            

        }completion:^(BOOL finished) {    [self.collectionView reloadData];}];
    }
    
    
    // Set the operation toggle back on
    isOperating = NO;
    
}

#pragma mark - UISCrollViewMethods?
// When you scroll to the bottom, it will call the API for a new request and load new images
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        //Execute the next set of operation here...
        if (APIActivate) { // Check if it's in real-time mode
            if (!isOperating) {
                NSLog(@"Executing new operation...");
                isOperating = YES;
                [self getMorePhotos];
            }
        }
    }
}

-(void) getMorePhotos{
    [self.downloader getArrayOfPhotoObjectsforTheSearchTerm:searchQuery];
}

#pragma mark - Methods for UIMotionEffect
-(void)setGundamGalleryInMotion: (UIImageView *)background {
    CGFloat min = -10.0f; // Adjust these numbers
    CGFloat max = 10.0f;
    
    // Create the x axis motion
    UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    
    xAxis.minimumRelativeValue = @(min);
    xAxis.maximumRelativeValue = @(max);
    
    // create the y axis motion
    UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    yAxis.minimumRelativeValue = @(min);
    yAxis.maximumRelativeValue = @(max);
    
    // Add both effect modules into the effect group
    UIMotionEffectGroup *AxisZeonMotionGroup = [[UIMotionEffectGroup alloc]init];
    AxisZeonMotionGroup.motionEffects = @[xAxis, yAxis];
    
    // Add the effect
    [background addMotionEffect:AxisZeonMotionGroup];
}


#pragma mode - Mode Switching Methods
-(void)clearGallery{
    self.photosets = nil;
    self.photosets = [[NSMutableArray alloc] init];
    [self.collectionView reloadData];
}

-(IBAction)SwitchMode:(id)sender{
    if (sender == _gundamSegControl) {
        if (self.gundamSegControl.selectedSegmentIndex == 0) {
            // Simulation Mode
            [self clearGallery];
            APIActivate = NO;
            NSString *imageExtension = @"jpg";
            NSArray *gundamPaths = [[NSBundle mainBundle] pathsForResourcesOfType:imageExtension
                                                                      inDirectory:nil];
            
            for (int i = 0; i < gundamPaths.count; i++) {
                [_photosets addObject:[UIImage imageNamed:gundamPaths[i]]];
            }
            
            [self.collectionView reloadData];
        }else{
            //Real-Time Mode
            [self clearGallery];
            APIActivate = YES;
            
            self.downloader = [FlickrDataDownloader sharedInstance];
            self.downloader.delegate = self;
            // END
            
            // Execute image load.
            [self.downloader getArrayOfPhotoObjectsforTheSearchTerm:searchQuery];
        }
    }
}

#pragma mark - Music Settings
-(IBAction)musicbtnClicked:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        if ([self.gundamPlayer isMusicPlaying]) {
            self.gundamPlayer = nil;
            [self.gundamPlayer stopGundamMusic];
            self.musicButton.title = @"Play";
        }else{
            // Set short background music
            self.gundamPlayer = [[BGManager alloc]init];
            [self.gundamPlayer configureAudioPlayer];
            [self.gundamPlayer playGundamMusic];
            self.musicButton.title = @"Stop";
        }
    }
}

@end
