//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@implementation PlayingCardDeck

-(instancetype)init{
    self=[super init]; //init parent classes
    
    if(self) //only if parent is init
    {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank=1; rank<=[PlayingCard maxRanks];rank++)
            {
                PlayingCard *card=[[PlayingCard alloc]init];
                card.suit=suit;
                card.rank=rank;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
