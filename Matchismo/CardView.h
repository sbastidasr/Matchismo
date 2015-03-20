//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Sebastian Bastidas on 3/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView


@property (nonatomic) BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;
-(void)drawContents;


-(CGFloat)cornerScaleFactor;
-(CGFloat)cornerRadius;
-(CGFloat)cornerOffset;

@end
