//
//  Card.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score=0;
    for (Card *card in otherCards){
    if ([card.contents isEqualToString:self.contents])
        score=1;
    }
    return score;
}



@end
