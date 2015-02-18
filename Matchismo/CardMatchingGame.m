//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/7/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "CardMatchingGame.h"

//Extension.
@interface CardMatchingGame()
@property(nonatomic) NSInteger score;//make the already defined property readwrite
@property(nonatomic) NSMutableArray *cards; //of cards. This one is related to the cards available in the UI. 12 in this case because UI has 12 dards.NOT the deck@end
@end

@implementation CardMatchingGame


-(NSMutableArray *)cards{
    if (!_cards){
        _cards= [[NSMutableArray alloc]init];
    }
     return _cards;
}
-(NSInteger)matchNumber{
    if(!_matchNumber){
        _matchNumber=2;
    }
    return _matchNumber;
}

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self=[super init];
    
    if(self)
    {
        for (int i=0; i<count; i++)
        {
            Card *card= [deck drawRandomCard];
            if(card){
            [self.cards addObject:card];
            }
            else{
                self=nil;//meaning it couldnt be init
                break;//not init
            }
        }
    }
    return self;
}

-(NSMutableString *)matchInfo{
    if (!_matchInfo){
        _matchInfo=[NSMutableString stringWithString:@" "];
    }
    return _matchInfo;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{
    self.started=YES;
    Card *card= [self cardAtIndex:index];
    
    if (!card.isMatched){
    if(card.isChosen){ //tapping a selected card deselects it.
        card.chosen=NO;
        self.matchInfo=[NSMutableString stringWithString:@" "];
    }
    else { //if it was not selected
        
        [self.matchInfo appendFormat:@"%@ ",card.contents];
        NSMutableArray *cards = [[NSMutableArray alloc]init]; //of selected cards
        [cards insertObject:card atIndex:0]; // add to array
        
        for (Card *otherCard in self.cards) { //iterate through game cards
            if(otherCard.isChosen&&!otherCard.isMatched){ //if other card was chosen and not already matched
                [cards insertObject:otherCard atIndex:0];
                if ([cards count]==self.matchNumber) { //found another selected card, check to see if they match.
                    int matchScore =[card match:cards];
                    if(matchScore){
                            //match!
                            self.matchInfo=[NSMutableString stringWithString:@"Matched :"];
                            self.score+=matchScore*MATCH_BONUS;
                            for (Card *selectedCard in cards) {
                                selectedCard.matched=YES;
                                [self.matchInfo appendFormat:@"%@ ",selectedCard.contents];
                            }
                            [self.matchInfo appendFormat:@"for %d points",matchScore*MATCH_BONUS];
                        }
                        else{
                            self.matchInfo=[NSMutableString stringWithString:@" "];
                            for (Card *selectedCard in cards) {
                                [self.matchInfo appendFormat:@"%@ ",selectedCard.contents];
                            }
                            [self.matchInfo appendFormat:@" do not match! lose %d points",MISMATCH_PENALTY];
                            //Mismatch, unchose last card, penalty
                            otherCard.chosen= NO;
                            self.score -= MISMATCH_PENALTY;
                        }
                    }
            }
           
        }
        self.score -= COST_TO_CHOSE;
        card.chosen=YES;
    }
    }
}



-(Card *)cardAtIndex:(NSUInteger) index{
            //if index is in bounds         do this         else nil
    return (index<[self.cards count]) ? self.cards[index] : nil;
}



@end
