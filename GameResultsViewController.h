//
//  GameResultsViewController.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/27/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameResultsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;
@property (strong, nonatomic) NSArray *scores;

@end
