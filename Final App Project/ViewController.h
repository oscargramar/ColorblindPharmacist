//
//  ViewController.h
//  Final App Project
//
//  Created by James Chen on 7/18/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameBoardView.h"
#import "boardPiece.h"
#import <AVFoundation/AVAudioPlayer.h>

static const NSInteger numberOfRows=7;
static const NSInteger numberOfColumns=5;

@interface ViewController : UIViewController{
    NSTimer *gameTimer;
    AVAudioPlayer *audioPlayer;
}



@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIView *timeAndScoreView;
@property (weak, nonatomic) IBOutlet UILabel *timerTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *pieceDescriptorText;
@property (weak, nonatomic) IBOutlet UIProgressView *timerBar;



@property(nonatomic) int descriptorShape;
@property(nonatomic) int descriptorColor;
@property(nonatomic) int descriptorTextColor;

@property(nonatomic) int randomPieceIndex;
@property(nonatomic,strong) boardPiece* randomBoardPiece;

@property(nonatomic) NSString* colorPrefix;
@property(nonatomic) NSString* shapeSuffix;

@property(nonatomic) gameBoardView* board;
@property(nonatomic) int timerCount;
@property(nonatomic) int scoreCount;
@property(nonatomic) int numberOfConsecutiveSuccesses;


@property(nonatomic) BOOL isGameOver;
@property(nonatomic) int randomNumber;


//@property(nonatomic,strong) NSMutableArray* boardPieceGridArray;
//@property(nonatomic,strong) NSMutableArray* buttonGridArray;
@property(nonatomic) UIImage* theNewImage;

@property(nonatomic) float singleRowHeight;
@property(nonatomic) float singleColumnWidth;

@property(nonatomic) int numberOfColumns;
@property(nonatomic) int numberOfRows;

@property(nonatomic) int index;
@property(nonatomic) CGRect pieceFrame;

@property(nonatomic,strong) boardPiece* clickedGamePiece;

- (void)initializeGameBoard:(gameBoardView*) board;
- (void)pieceButtonClicked: (id) sender;
- (void)shuffleBoardPieces;

- (void)startTimerCountdown:(int) counts;
- (void)countdownTimer:(NSTimer *) theTimer;

- (void)generateRandomDescriptorText;
-(UIButton*)getGamePieceButton:(NSInteger)atRow andColumn:(NSInteger)atColumn;
-(boardPiece*)getGameBoardPiece:(NSInteger)atRow andColumn:(NSInteger)atColumn;


@end
