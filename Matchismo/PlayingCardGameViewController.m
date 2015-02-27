//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/21/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "PlayingCardGameViewController.h"

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    self.gameType = @"Playing Cards";
    return [[PlayingCardDeck alloc]init];

}

@end
