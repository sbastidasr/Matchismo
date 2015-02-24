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

-(Deck *)createDeck{
    return [[SetCardDeck alloc]init];
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

- (IBAction)changeMatchMode:(UISegmentedControl *)sender {
    self.game.matchNumber=3;
}


-(NSArray *)symbolsArray{
    return @[@"▲",@"●",@"■"];
}
-(NSArray *)colorsArray{
    return @[[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor]];
}


-(NSAttributedString *)titleForCard:(SetCard *)card{
    NSString *contents = [NSString stringWithFormat: @"%ld%@", (long)card.number,[[self symbolsArray] objectAtIndex:card.symbol]];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:contents];
    NSNumber *myNum = [NSNumber numberWithInteger:card.shading];
    
    [title setAttributes:@{NSForegroundColorAttributeName:[[self colorsArray] objectAtIndex:card.color],
                           NSStrokeWidthAttributeName:myNum}
                   range:NSMakeRange(0, [title length])];
    return card.isChosen ? title : @"";
}

@end
