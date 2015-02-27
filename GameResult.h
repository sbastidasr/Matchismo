//
//  GameResult.h
//  Matchismo
//
//  Created by Sebastian Bastidas on 2/27/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; //Array with history of results.

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *gameType;

- (NSComparisonResult)compareDate:(GameResult *)result;
- (NSComparisonResult)compareScore:(GameResult *)result;
- (NSComparisonResult)compareDuration:(GameResult *)result;

@end
