//
//  ViewController.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
#import "CardView.h"

@interface CardGameViewController : UIViewController

@property (nonatomic,strong) CardMatchingGame *game;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; Not used anymore. Instead use cards array
@property (nonatomic,strong) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
//@property (weak, nonatomic) IBOutlet UILabel *matchInfoLabel;
@property (strong, nonatomic) NSString *gameType;

@property (nonatomic) NSUInteger cardsInGame;
@property (strong, nonatomic) GameResult *gameResult;

-(Deck *)createDeck;
-(UIImage *)backgroundImageForCard:(Card *)card;
-(void)updateUI;
- (CardView *)newCardOfGameTypeWithFrame:(CGRect)cardSpace;

@end

