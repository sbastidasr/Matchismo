//
//  ViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "GameResult.h"

@interface CardGameViewController ()

@property (strong, nonatomic) NSMutableArray *history;
@property (strong, nonatomic) GameResult *gameResult;

@end


@implementation CardGameViewController

- (GameResult *)gameResult{
    if (!_gameResult){
        _gameResult = [[GameResult alloc] init];
    }
    _gameResult.gameType = self.gameType;
    return _gameResult;
}

-(NSMutableArray *)history{
    if(!_history){
        _history=[[NSMutableArray alloc]init];
    }
    return _history;
}

-(CardMatchingGame *)game{
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
    self.gameResult = nil;
}

-(void)updateUI{
    [self.matchModeControl setEnabled:![self.game isStarted]];
    
    self.matchInfoLabel.attributedText = [self getGameDescriptionFromString:self.game.matchInfo];
    [self.history addObject:self.matchInfoLabel.attributedText];
    
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
        self.gameResult.score = self.game.score;
    }
}

-(NSAttributedString *)getGameDescriptionFromString:(NSString*)description{
    NSAttributedString *label= [[NSAttributedString alloc] initWithString:description];
    return  label;
}

-(NSAttributedString *)titleForCard:(Card *)card{
    NSString *title= card.isChosen ? card.contents : @"";
    return[[NSAttributedString alloc] initWithString:title];
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront"  : @"cardBack" ];
}

-(Deck *)createDeck{ //abstract
    return nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"History"] || [segue.identifier isEqualToString:@"History2"]){
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
            HistoryViewController *historyVC = (HistoryViewController *)segue.destinationViewController;
            historyVC.history=self.history;    //do stuff.
        }
    }
}

@end
