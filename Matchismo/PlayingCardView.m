//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Sebastian Bastidas on 3/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "PlayingCardView.h"
@interface PlayingCardView()
@property(nonatomic)CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

@synthesize faceCardScaleFactor=_faceCardScaleFactor;
#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

-(CGFloat)faceCardScaleFactor{
    if (!_faceCardScaleFactor){
        _faceCardScaleFactor= DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}
-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor{
    _faceCardScaleFactor=faceCardScaleFactor;
    [self setNeedsDisplay];
}


#pragma mark - Properties
-(void)setSuit:(NSString *)suit{
    _suit=suit;
    [self setNeedsDisplay];
}
-(void)setRank:(NSUInteger)rank{
    _rank=rank;
    [self setNeedsDisplay];
}
-(void)setFaceUp:(BOOL)faceUp{
    _faceUp=faceUp;
    [self setNeedsDisplay];
}

-(void)pinch:(UIPinchGestureRecognizer *)gesture{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded)){
           self.faceCardScaleFactor *= gesture.scale;
           gesture.scale=1.0;
       }
}

#pragma mark - Drawing
#define CORNER_FONT_STANDARD_HEIGHT 100.0
#define CORNER_RADIUS 12.0
-(CGFloat)cornerScaleFactor{return self.bounds.size.height/CORNER_FONT_STANDARD_HEIGHT;}
-(CGFloat)cornerRadius{return CORNER_RADIUS * [self cornerScaleFactor]; }
-(CGFloat)cornerOffset {return [self cornerRadius] / 3.0; }

-(void)drawRect:(CGRect)rect{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    [roundedRect fill];
    
    if (self.faceUp){
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        if (faceImage){
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width*(1.0-self.faceCardScaleFactor),
                                           self.bounds.size.width*(1.0-self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        }
        else{
            [self drawPips];
        }
        [self drawCorners];
    }
    else{
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

-(void)drawPips{}

-(NSString *)rankAsString{
    return @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

-(void)drawCorners{
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


#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //
    }
    return self;
}

-(void)setup{
    self.backgroundColor = nil;
    self.opaque=NO;
    self.contentMode=UIViewContentModeRedraw;
}
-(void)awakeFromNib{
    [self setup];
}






@end
