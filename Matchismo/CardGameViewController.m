//
//  ViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"

#import "Grid.h"

@interface CardGameViewController ()

@property (strong, nonatomic) NSMutableArray *history;
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UIView *cardContainerView;

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

//hardwired??
-(NSUInteger)cardsInGame{
    return 12;
}


-(CardMatchingGame *)game{
    if(!_game){
        _game=[[CardMatchingGame alloc] initWithCardCount:self.cardsInGame usingDeck:[self createDeck]];
    }
    return _game;
}

- (IBAction)changeMatchMode:(UISegmentedControl *)sender {
    self.game.matchNumber=sender.selectedSegmentIndex+2;
}



- (IBAction)touchCardButton:(UITapGestureRecognizer*)sender {
    UIView *view = sender.view;
   CardView *pcv = (CardView *)view;
    
    
       //get #of selected card in view.
    NSUInteger chosenButtonIndex = [self.cardViews indexOfObject:pcv];
    
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

-(Grid *)grid{
    if(!_grid){
        _grid=[[Grid alloc]init];
        _grid.cellAspectRatio = 0.7;
        _grid.size=CGSizeMake(380, 400);
        _grid.minimumNumberOfCells=self.cardsInGame;
    }
    return _grid;
}


-(NSArray *)cardViews{
    if (!_cardViews){
        _cardViews=[[NSMutableArray alloc]init];
        NSUInteger availableCards=0;
        
        for (int row = 0; row < self.grid.rowCount; row++) {
            for (int column = 0; column < self.grid.columnCount; column++) {
                CGRect cardSpace =  CGRectInset([self.grid frameOfCellAtRow:row inColumn:column], 10, 10);
                if (availableCards<self.cardsInGame){
                
                    CardView *card = [self newCardOfGameTypeWithFrame:cardSpace];
                   
                    [self.cardContainerView addSubview:card];
                    [_cardViews addObject:card];
                    availableCards++;
                    
                    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCardButton:)];
                    [card addGestureRecognizer:letterTapRecognizer];
                }
            }
        }
    }
     return _cardViews;
}


- (CardView *)newCardOfGameTypeWithFrame:(CGRect)cardSpace{ //abstract
    return nil;
}

 - (void)viewDidLoad {
     [super viewDidLoad];
     [self updateUI];

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
