//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Sebastian Bastidas on 3/6/15.
//  Copyright (c) 2015 sbastidasr. All rights reserved.
//

#import "CardView.h"
@interface CardView()
@property(nonatomic)CGFloat faceCardScaleFactor;
@end

@implementation CardView

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
       // UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        
        [self drawPips];
        
        [self drawContents];
    }
    else{
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

-(void)drawPips{}




#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = nil;
    self.opaque=NO;
    self.faceUp=YES;
    self.contentMode=UIViewContentModeRedraw;
}
-(void)awakeFromNib{
    [self setup];
}






@end
