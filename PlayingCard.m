//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

//synthesize, getters, setters for validation

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents{
    NSArray *rankStrings=[PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

//Getters+setters

@synthesize suit=_suit;//because we provide getter and setter.

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])//Class methods are called with classname, not self
    {
        _suit=suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";//if ? talcaosa; elsetalcosa
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRanks])
        _rank=rank;
}

-(int)match:(NSArray *)othercards{
    int score=0;
    if([othercards count]==1)//matching only one card
    {
        PlayingCard *otherCard = [othercards firstObject];
        if(otherCard.rank ==self.rank)
        {
            score=4;
        }
        else if (otherCard.suit ==self.suit)
        {
            score=1;
        }
    }
    return score;
}

//Utilities are class methods.
+(NSUInteger) maxRanks{
    return [[self rankStrings] count]-1;
}

+(NSArray *)validSuits{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}
+(NSArray *)rankStrings{
    return @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

@end
