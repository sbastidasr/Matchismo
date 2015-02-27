//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/26/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "HistoryViewController.h"

@implementation HistoryViewController

-(void)viewDidAppear:(BOOL)animated{
    NSMutableAttributedString *logs = [[NSMutableAttributedString alloc]init];
    for (NSAttributedString *log in self.history){
        [logs appendAttributedString:log];
        [logs appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n" attributes:nil]];
    }
    
    self.historyTextView.attributedText=logs;
}
@end
