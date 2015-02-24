//
//  SetCard.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/23/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property(nonatomic) NSUInteger number;
@property(nonatomic) NSUInteger symbol;
@property(nonatomic) NSUInteger shading;
@property(nonatomic) NSUInteger color;

+(NSArray *)validValues;


//+(NSUInteger) maxRanks;

@end
