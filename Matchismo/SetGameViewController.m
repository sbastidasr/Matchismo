//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/24/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCard.h"

@implementation SetGameViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self updateUI];
    self.game.matchNumber=3;
}

- (Deck *)createDeck{
    self.gameType = @"Set Cards";
    return [[SetCardDeck alloc] init];
}

-(NSAttributedString *)getGameDescriptionFromString:(NSString*)description{
    NSLog(@"%@",description);
    NSArray *cards = [description componentsSeparatedByString:@":"];
    
    NSUInteger numberOfCards = ([cards count]-1)/5;
    NSMutableAttributedString *label = [[NSMutableAttributedString alloc]init];
    
    for (int i=0; i<numberOfCards; i++){
        
    SetCard *setCard = [[SetCard alloc]init];
       
    setCard.symbol=cards[1+(i*5)];
    setCard.color=cards[2+(i*5)];
    setCard.shading=cards[3+(i*5)];
    setCard.number=[cards[4+(i*5)] integerValue];
    [label appendAttributedString: [self titleForCard:setCard]];
    }
     NSMutableAttributedString *labelEnd= [[NSAttributedString alloc] initWithString:[cards lastObject]] ;
    
    if(labelEnd){
    [label appendAttributedString: labelEnd];
    }
     return  label;
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardSelected"  : @"cardFront" ];
}

- (NSAttributedString *)titleForCard:(SetCard *)setCard{
    NSString *symbol = @"";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];

    UIFont *newFont = [UIFont fontWithName:@"Helvetica Neue" size:12];
    NSArray *symbolsArray= @[@"●", @"▲", @"■"];
    NSArray *colorsArray= @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
    
    if([[SetCard validSymbols] containsObject:setCard.symbol]){  //symbol+length
        symbol = [symbolsArray objectAtIndex: [[SetCard validSymbols] indexOfObject:setCard.symbol]];
         symbol = [symbol stringByPaddingToLength:setCard.number withString:symbol startingAtIndex:0];
    }
    
    if([[SetCard validColors] containsObject:setCard.color]){ //color
     UIColor *color=[colorsArray objectAtIndex: [[SetCard validColors] indexOfObject:setCard.color]];
    [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    if ([setCard.shading isEqualToString:@"solid"]){
        [attributes setObject:@-5   forKey:NSStrokeWidthAttributeName];
    }
    
    if ([setCard.shading isEqualToString:@"striped"]){
        [attributes addEntriesFromDictionary:@{ NSStrokeWidthAttributeName : @-5,
                                                NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName]
                                                                                     colorWithAlphaComponent:0.1] }];
    }
    
    if ([setCard.shading isEqualToString:@"open"]){
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    }
    
    [attributes setObject:newFont forKey:NSFontAttributeName ];
    return [[NSMutableAttributedString alloc] initWithString:symbol  attributes:attributes];
}

@end
