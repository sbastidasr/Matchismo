//
//  ViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic,strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *matchInfoLabel;

@end

@implementation ViewController

-(CardMatchingGame *)game
{
    if(!_game){
        _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (IBAction)changeMatchMode:(UISegmentedControl *)sender {
    self.game.matchNumber=sender.selectedSegmentIndex+2;
}


- (IBAction)touchCardButton:(UIButton *)sender {
  //the model now handles what happens when selecting a card.
    
    //get #of selected card in view.
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    //set card of that number in game model.
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    //controller has to update what happened in the game.
    [self updateUI];
  
}
- (IBAction)newGameButton:(UIButton *)sender {
    self.game = nil;
     self.game =[self game];
    [self updateUI];
}

-(void)updateUI{
    [self.matchModeControl setEnabled:![self.game isStarted]];
    
   self.matchInfoLabel.text=self.game.matchInfo;
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:cardButton]; //card index in view
        //get card at that index in game
        Card *card = [self.game cardAtIndex:index];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    }
}
-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront"  : @"cardBack" ];
}



-(Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}
@end
