//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/24/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck


 -(instancetype)init{
     self=[super init]; //init parent classes
     if(self){//only if parent is init
         for (NSNumber *suit in [SetCard validValues]) {
             for (NSNumber *rank in [SetCard validValues]) {
                 for (NSNumber *shading in [SetCard validValues]) {
                      for (NSNumber *color in [SetCard validValues]) {
                          
                          SetCard *card=[[SetCard alloc]init];
                          card.number=[suit integerValue];
                          card.color=[color integerValue];
                          card.symbol=[rank integerValue];
                          card.shading=[shading integerValue];
                          [self addCard:card];
                          
                      }
                 }
             }
         }
     }
     return self;
 }

@end
