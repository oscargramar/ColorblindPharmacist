//
//  boardPiece.h
//  Final App Project
//
//  Created by James Chen on 7/18/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface boardPiece : NSObject

@property(nonatomic) int pieceColor;
@property(nonatomic) int pieceShape;
@property(nonatomic) NSString* pieceImage;



+(boardPiece *)generateRandomGamePiece;

-(int)randomNumberGenerator: (int) upperBound;

@end


