//
//  pieceButton.m
//  Final App Project
//
//  Created by James Chen on 7/21/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import "pieceButton.h"

@implementation pieceButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(pieceButton *)createPieceButtonFromGamePiece:(boardPiece *) gamePiece atFrame: (CGRect*) frame{
    pieceButton *gamePieceButton = [[pieceButton alloc ]initWithFrame:*frame];
    gamePieceButton.pieceColorProperty = gamePiece.pieceColor;
    gamePieceButton.pieceShapeProperty = gamePiece.pieceShape;
    gamePieceButton.pieceImageName = gamePiece.pieceImage;
    gamePieceButton.buttonImage = [UIImage imageNamed:gamePieceButton.pieceImageName];
    
    [gamePieceButton setImage:gamePieceButton.buttonImage forState:UIControlStateNormal];
    return gamePieceButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
