//
//  boardPiece.m
//  Final App Project
//
//  Created by James Chen on 7/18/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import "boardPiece.h"
#import "ViewController.h"

@implementation boardPiece
@synthesize pieceShape;
@synthesize pieceColor;
@synthesize pieceImage;


+(boardPiece *)generateRandomGamePiece{
    boardPiece *gamePiece = [[boardPiece alloc] init];
    gamePiece.pieceColor = [gamePiece randomNumberGenerator:7];
    gamePiece.pieceShape = [gamePiece randomNumberGenerator:3];

    NSString* colorPrefix;
    NSString* shapeSuffix;
    
    
    
    
    if(gamePiece.pieceColor==1) {colorPrefix=@"blue";}
    if(gamePiece.pieceColor==2) {colorPrefix=@"green";}
    if(gamePiece.pieceColor==3) {colorPrefix=@"orange";}
    if(gamePiece.pieceColor==4) {colorPrefix=@"pink";}
    if(gamePiece.pieceColor==5) {colorPrefix=@"purple";}
    if(gamePiece.pieceColor==6) {colorPrefix=@"red";}
    if(gamePiece.pieceColor==7) {colorPrefix=@"yellow";}
    
    if(gamePiece.pieceShape==1) {shapeSuffix=@"Capsule.png";}
    if(gamePiece.pieceShape==2) {shapeSuffix=@"Tablet.png";}
    if(gamePiece.pieceShape==3) {shapeSuffix=@"Pill.png";}

    
    gamePiece.pieceImage=[colorPrefix stringByAppendingString:shapeSuffix];
    //NSLog(@"pieceIMage: %@", gamePiece.pieceImage);
    return gamePiece;
}

-(int)randomNumberGenerator: (int) upperBound{
    return arc4random_uniform(upperBound)+1;
}




@end
