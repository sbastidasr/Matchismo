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

#pragma mark - utilities
+(NSUInteger) maxRanks{
    return [[self rankStrings] count]-1;
}

+(NSArray *)validSuits{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}
+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

#pragma mark - Methods
-(NSString *)contents{
    NSArray *rankStrings=[PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

#pragma mark - Getters & Setters
@synthesize suit=_suit;//because we provide getter and setter.

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])//Class methods are called with classname, not self
    {
        _suit=suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit : @"?";//if ? talcaosa; elsetalcosa
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRanks])
        _rank=rank;
}

-(int)match:(NSArray *)othercards{
    int score=0;

    //Create a counted set of suits of the selected cards
    NSMutableArray *cardSuits = [NSMutableArray new];
    for (PlayingCard *card in othercards) {
        [cardSuits addObject:card.suit];
    }
    NSCountedSet *suitsCountedSet = [[NSCountedSet alloc] initWithArray:cardSuits];

    //Create a counted set of raksb of the selected cards
    NSMutableArray *cardRanks = [NSMutableArray new];
    for (PlayingCard *card in othercards) {
        [cardRanks addObject:[NSString stringWithFormat:@" %tu ", card.rank]];
    }
    NSCountedSet *ranksCountedSet = [[NSCountedSet alloc] initWithArray:cardRanks];
    
    //Get the score, increasing number of matches gets a bonus!
    for (NSString *rank in ranksCountedSet)
    {   // matching ranks gets 4
        score += 4*([ranksCountedSet countForObject:rank]-1);
    }
    for (NSString *suit in suitsCountedSet)
    {   // matching suits gets 1
        score += 1*([suitsCountedSet countForObject:suit]-1);
    }
    return score;
}

@end
