//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Sebastian Bastidas on 3/18/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

-(void)setSuit:(NSString *)suit{
    _suit=suit;
    [self setNeedsDisplay];
}
-(void)setRank:(NSUInteger)rank{
    _rank=rank;
    [self setNeedsDisplay];
}

-(NSString *)rankAsString{
    return @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}


-(void)drawContents{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment=NSTextAlignmentCenter;
    
    UIFont *cornerFont=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont=[cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *cornerText= [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString], self.suit] attributes:@{NSFontAttributeName:cornerFont, NSParagraphStyleAttributeName:paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin=CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size=[cornerText size];
    [cornerText drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}


@end
