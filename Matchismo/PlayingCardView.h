//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 3/18/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "CardView.h"

@interface PlayingCardView : CardView
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@end
