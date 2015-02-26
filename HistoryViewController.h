//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/26/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *history;
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end
