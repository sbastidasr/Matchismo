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
    return [[SetCardDeck alloc] init];
}

-(void)updateUI{
    [self.matchModeControl setEnabled:![self.game isStarted]];
    
    self.matchInfoLabel.text=self.game.matchInfo;
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:cardButton]; //card index in view
        //get card at that index in game
        Card *card = [self.game cardAtIndex:index];
        
        
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        
    }
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardSelected"  : @"cardFront" ];
}




//edit this method!!!!!
- (NSAttributedString *)titleForCard:(SetCard *)setCard
{
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
