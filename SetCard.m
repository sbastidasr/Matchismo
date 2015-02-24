//
//  SetCard.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/23/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(NSString *)contents{
    return [NSString stringWithFormat:@"%d%d%d", self.number, self.symbol, self.shading, self.color];
}

/*
 
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
 */


 -(int)match:(NSArray *)othercards{
 int score=0;
     
 //Create a counted set of suits of the selected cards
 NSMutableArray *cardSuits = [NSMutableArray new];
 for (SetCard *card in othercards) {
 [cardSuits addObject:card.suit];
 }
 NSCountedSet *suitsCountedSet = [[NSCountedSet alloc] initWithArray:cardSuits];
     
 //Create a counted set of raksb of the selected cards
 NSMutableArray *cardRanks = [NSMutableArray new];
 for (SetCard *card in othercards) {
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
 
/*
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
*/
 

+(NSArray *)validValues{
    return @[@0,@1,@2];
}




@end
//number (one, two, or three); symbol (diamond, squiggle, oval); shading (solid, striped, or open); and color (red, green, or purple).[



