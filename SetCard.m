//
//  SetCard.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/23/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - ClassMethods
+ (NSArray *)validColors{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSArray *)validShadings{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber{
    return 3;
}

#pragma mark - Getters & Setters
@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)contents{
    return [NSString stringWithFormat:@" :%@:%@:%@:%d: ", self.symbol, self.color, self.shading, self.number];
}

- (void)setNumber:(NSUInteger)number{
    if (number <= [SetCard maxNumber]){
        _number = number;
    }
}

- (NSString *)color{
    return _color ? _color : @"?";
}
- (void)setColor:(NSString *)color{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol{
    return _symbol ? _symbol : @"?";
}
- (void)setSymbol:(NSString *)symbol{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading{
    return _shading ? _shading : @"?";
}
- (void)setShading:(NSString *)shading{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

#pragma mark - Methods

- (int)match:(NSArray *)otherCards{
    int score = 0;
    if (otherCards.count == 3){
        NSMutableArray *numbers = [[NSMutableArray alloc]init];
        NSMutableArray *shades = [[NSMutableArray alloc]init];
        NSMutableArray *colors = [[NSMutableArray alloc]init];
        NSMutableArray *symbols = [[NSMutableArray alloc]init];
        
        for (SetCard *otherCard in otherCards) {
            if (! [numbers containsObject:@(otherCard.number)] ) {
                [numbers addObject:@(otherCard.number)];
            }
            if (! [shades containsObject:otherCard.shading] ) {
                [shades addObject:otherCard.shading];
            }
            if (! [colors containsObject:otherCard.color] ) {
                [colors addObject:otherCard.color];
            }
            if (! [symbols containsObject:otherCard.symbol] ) {
                [symbols addObject:otherCard.symbol];
            }
        }
        
        if ((numbers.count==1 || numbers.count == 3)&& (shades.count==1 || shades.count == 3)&&
            (colors.count==1 || colors.count == 3)&&
            (symbols.count==1 || symbols.count == 3)){
                score=4;
        }
        
        
    }
    return score;
}

@end




