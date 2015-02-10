//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/7/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "Deck.h"

@interface CardMatchingGame : Deck

//initializing game with a certain amount of cards in UI  and a random deck
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

//when a user selects a card
-(void)chooseCardAtIndex:(NSUInteger)index;

//getting a card to display in the UI.
-(Card *)cardAtIndex:(NSUInteger) index;

//Game score. It is readonly for the public.
@property(nonatomic,readonly) NSInteger score;


@end
