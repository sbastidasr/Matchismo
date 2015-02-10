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
@property(nonatomic) NSMutableArray *cards; //of cards. This one is related to the cards available in the UI. 12 in this case because UI has 12 dards.NOT the deck
@property(nonatomic) NSInteger numberOfMatchCards;
@end


@implementation CardMatchingGame


-(NSMutableArray *)cards{
    if (!_cards){
        _cards= [[NSMutableArray alloc]init];
    }
     return _cards;
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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card= [self cardAtIndex:index];
    if (!card.isMatched){
    if(card.isChosen)//tapping a selected card deselects it.
        card.chosen=NO;
    else{ //if it was not selected
        for (Card *otherCard in self.cards) { //iterate through game cards
            if(otherCard.isChosen&&!otherCard.isMatched){ //if other card was chosen and not already matched
    
                //if we find another selected card, chec to see if they match.
                int matchScore =[card match:@[otherCard]];
                if(matchScore){
                    //match!
                    self.score+=matchScore*MATCH_BONUS;
                    otherCard.matched=YES;
                    card.matched=YES;
                }
                else
                {
                    //Mismatch, unchose card, penalty
                    otherCard.chosen=NO;
                    self.score -= MISMATCH_PENALTY;
                }
                break; //only two cards can be selected.
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
