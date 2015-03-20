//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/21/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "GameResult.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    self.gameType = @"Playing Cards";
    return [[PlayingCardDeck alloc]init];

}

-(void)updateUI{
    [self.matchModeControl setEnabled:![self.game isStarted]];
    
    for (PlayingCardView *cardView in self.cardViews) {
        NSUInteger index = [self.cardViews indexOfObject:cardView]; //card index in view
        //get card at that index in game
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:index];
        
        
        cardView.suit=card.suit;
        cardView.rank=card.rank;

       
        cardView.faceUp = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        super.gameResult.score = super.game.score;
    }
}

- (CardView *)newCardOfGameTypeWithFrame:(CGRect)cardSpace{
    return [[PlayingCardView alloc]initWithFrame:cardSpace];
}


@end
