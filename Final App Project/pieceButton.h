//
//  pieceButton.h
//  Final App Project
//
//  Created by James Chen on 7/21/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "boardPiece.h"

@interface pieceButton : UIButton

@property(nonatomic) int pieceColorProperty;
@property(nonatomic) int pieceShapeProperty;
@property(nonatomic) NSString* pieceImageName;
@property(nonatomic,strong) UIImage* buttonImage;
@property(nonatomic,strong) UIButton* pieceButton;


+(pieceButton *)createPieceButtonFromGamePiece: (boardPiece *) gamePiece atFrame: (CGRect *) frame;

@end
