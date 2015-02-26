//
//  SetGameViewController.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/24/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "CardGameViewController.h"
#import "SetCardDeck.h"

@interface SetGameViewController : CardGameViewController

- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;



+(NSArray *)symbolsArray;
@end
