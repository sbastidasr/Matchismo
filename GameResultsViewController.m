//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/27/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@implementation GameResultsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scores = [GameResult allGameResults];
    [self updateUI];
}

- (void)updateUI{
    NSString *text = @"";
    for (GameResult *result in self.scores) {
        text = [text stringByAppendingString:[self stringFromResult:result]];
    }
    self.scoresTextView.text = text;
    
    NSArray *sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor redColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor greenColor]];
    sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor purpleColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor blueColor]];
}

- (NSString *)stringFromResult:(GameResult *)result{
    return [NSString stringWithFormat:@"%@: %d, (%@, %gs)\n",
            result.gameType,
            result.score,
            [NSDateFormatter localizedStringFromDate:result.end
                                           dateStyle:NSDateFormatterShortStyle
                                           timeStyle:NSDateFormatterShortStyle],
            round(result.duration)];
}

- (void)changeScore:(GameResult *)result toColor:(UIColor *)color{
    NSRange range = [self.scoresTextView.text rangeOfString:[self stringFromResult:result]];
    [self.scoresTextView.textStorage addAttribute:NSForegroundColorAttributeName
                                            value:color
                                            range:range];
}
- (IBAction)sortByDate:(id)sender {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}
- (IBAction)sortByScore:(id)sender {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}
- (IBAction)sortByDuration:(id)sender {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
}

@end
