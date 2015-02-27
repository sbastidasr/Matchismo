//
//  PlayingCard.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

+(NSArray *)validSuits;
+(NSArray *)validRanks;
+(NSUInteger) maxRanks;

@property(nonatomic,strong) NSString *suit;
@property(nonatomic) NSUInteger rank;

@end
