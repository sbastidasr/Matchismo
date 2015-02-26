//
//  SetCard.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/23/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;



@end
