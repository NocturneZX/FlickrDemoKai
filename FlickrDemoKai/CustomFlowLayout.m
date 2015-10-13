//
//  CustomFlowLayout.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/17/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "CustomFlowLayout.h"

@interface CustomFlowLayout ()

@property (nonatomic, strong) NSMutableSet *visibleIndexPaths;
@property (nonatomic, assign) CGFloat latestDelta;

@end
/*
 
    This implementation is based on https://github.com/TeehanLax/UICollectionView-Spring-Demo
    which Ash Furrow developed at Teehan+Lax. Check it out.
 
 */

@implementation CustomFlowLayout

-(instancetype)init {
    if (!(self = [super init])) return nil;
    
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(150, 150);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    self.visibleIndexPaths = [NSMutableSet set];
    
    return self;
}

-(void)prepareLayout {
    [super prepareLayout];
    
    // Overflowing the actual visible rectangle to avoid flickering.
    CGRect collectionViewrect = CGRectMake(self.collectionView.bounds.origin.x, self.collectionView.bounds.origin.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGRect visibleRect = CGRectInset(collectionViewrect, -150, -150);
    
    NSArray *visibleRectArray = [super layoutAttributesForElementsInRect:visibleRect];
    
    NSSet *indexPathsInVisibleRectSet = [NSSet setWithArray:[visibleRectArray valueForKey:@"indexPath"]];
    
    // Remove any behaviours that are no longer visible.
    NSArray *noLongerVisibleBehaviors = [self.dynamicAnimator.behaviors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *behaviour, NSDictionary *bindings) {
        return [indexPathsInVisibleRectSet containsObject:[(UICollectionViewLayoutAttributes *)[[behaviour items] firstObject] indexPath]] == NO;
    }]];
    
    [noLongerVisibleBehaviors enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
        [self.dynamicAnimator removeBehavior:obj];
        [self.visibleIndexPaths removeObject:[(UICollectionViewLayoutAttributes *)[[obj items] firstObject] indexPath]];
    }];
    
    // Add any new visible behaviours.
    NSArray *newVisibleItems = [visibleRectArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *item, NSDictionary *bindings) {
        BOOL currentlyVisible = [self.visibleIndexPaths member:item.indexPath] != nil;
        return !currentlyVisible;
    }]];
    
    //
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    [newVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger idx, BOOL *stop) {
        CGPoint center = item.center;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:center];
        
        springBehavior.length = 0.5f;
        springBehavior.damping = 0.9f;
        springBehavior.frequency = 1.0f;
        
        // If our touchLocation is not (0,0), we'll need to adjust our item's center "in flight"
        if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
            CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehavior.anchorPoint.y);
            CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehavior.anchorPoint.x);
            CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1800.0f;
            
            if (_latestDelta < 0) {
                center.y += MAX(_latestDelta, _latestDelta * scrollResistance);
            }
            else {
                center.y += MIN(_latestDelta, _latestDelta * scrollResistance);
            }
            item.center = center;
        }
        
        [self.dynamicAnimator addBehavior:springBehavior];
        [self.visibleIndexPaths addObject:item.indexPath];
    }];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return [self.dynamicAnimator itemsInRect:rect];
}

//
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    // If there are no layoutAttributes for any new cells added in the view, return super until new
    //layouts and behaviors are implemented. Without it, the app will crash whenever you scroll to the bottom.
    if(!layoutAttributes) {
        layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    }
    return layoutAttributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat nuDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    self.latestDelta = nuDelta;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehavior, NSUInteger idx, BOOL *stop) {
        
        CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehavior.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1800.0f;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *) [springBehavior.items firstObject];
        CGPoint center = item.center;
        if (nuDelta < 0) {
            center.y += MAX(nuDelta, nuDelta * scrollResistance);
        }
        else {
            center.y += MIN(nuDelta, nuDelta * scrollResistance);
        }
        
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}

@end
