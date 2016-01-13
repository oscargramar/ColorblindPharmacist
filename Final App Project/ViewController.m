//
//  ViewController.m
//  Final App Project
//
//  Created by James Chen on 7/18/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import "ViewController.h"
#import "gameBoardView.h"
#import "boardPiece.h"
#import "GameOverVC.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface ViewController ()

@end

@implementation ViewController{
    boardPiece* boardPieceGridArray[numberOfRows][numberOfColumns];
    UIButton* buttonGridArray[numberOfRows][numberOfColumns];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self.timeAndScoreView layer]setBorderWidth:1.0f];
    [[self.timeAndScoreView layer]setBorderColor:[[UIColor blackColor] CGColor]];
    
    //[self.view setBackgroundColor:[UIColor blackColor]];
    //[self invertBackgroundColor];
    
    _board = [[gameBoardView alloc]initWithFrame:CGRectMake(10, 120, 330, 430)];
    [self initializeGameBoard:_board];
    [self.view addSubview:_board];
    [self generateRandomDescriptorText];
    self.scoreCount=0;
    [self updateScoreLabel];
    self.numberOfConsecutiveSuccesses = 0;
    [self startTimerCountdown:30];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"coinSoundEffect" ofType:@"wav"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];

    
    self.isGameOver = NO;
}


- (void)initializeGameBoard:(gameBoardView*) board{
//    self.boardPieceGridArray = [[NSMutableArray alloc] init];
//    self.buttonGridArray = [[NSMutableArray alloc] init];

//    self.numberOfRows = 7;
//    self.numberOfColumns = 5;
    self.index=0;
    
    self.singleRowHeight = board.frame.size.height/numberOfRows;
    self.singleColumnWidth = board.frame.size.width/numberOfColumns;
    
    for (int row = 0; row<numberOfRows; row++) {
        for (int column = 0; column<numberOfColumns; column++) {
            
            boardPiece *gamePiece = [boardPiece generateRandomGamePiece];
            //[self.boardPieceGridArray addObject:gamePiece];
            boardPieceGridArray[row][column] = gamePiece; //NEW!!!
            
            UIImage *gamePieceImage = [UIImage imageNamed:gamePiece.pieceImage];
            
            
            board.userInteractionEnabled = YES;
            UIButton *pieceButton = [[UIButton alloc] initWithFrame:CGRectMake(_singleColumnWidth * column, _singleRowHeight * row, .45*gamePieceImage.size.width, .45*gamePieceImage.size.height)];
            [pieceButton setImage:gamePieceImage forState:UIControlStateNormal];
            [pieceButton addTarget:self action:@selector(pieceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            pieceButton.tag = self.index;
            //[self.buttonGridArray addObject:pieceButton];
            buttonGridArray[row][column] = pieceButton; //NEW!!!
            
            [board addSubview:pieceButton];
            self.index++;
            
        }
        
    }
}

- (void) invertBackgroundColor{
    self.randomNumber=arc4random_uniform(100)+1;
    if(self.randomNumber<30) {
        self.view.backgroundColor = [UIColor blackColor];
        
    }
    else self.view.backgroundColor = [UIColor whiteColor];
}


- (void)updateScoreLabel{
    self.scoreTextLabel.text = [NSString stringWithFormat:@"%d",self.scoreCount];
}

- (void)pieceButtonClicked: (id) sender{
    if(self.isGameOver == NO){
        int rowNumber = [sender tag]/5;
        int columnNumber = [sender tag] %5;
        //self.clickedGamePiece = [self.boardPieceGridArray objectAtIndex:[sender tag]];
        self.clickedGamePiece = boardPieceGridArray[rowNumber][columnNumber];
    
        if (self.clickedGamePiece.pieceColor==self.descriptorColor && self.clickedGamePiece.pieceShape==self.descriptorShape) {
            if(self.scoreCount<20) self.scoreCount+=1;
            else if(self.scoreCount<50) self.scoreCount+=2;
            else if(self.scoreCount<150) self.scoreCount+=5;
            else if(self.scoreCount<500) self.scoreCount+=10;
            else if(self.scoreCount<1000) self.scoreCount+=20;
            else if(self.scoreCount>=1000) self.scoreCount+=50;
            
            [self updateScoreLabel];
            self.numberOfConsecutiveSuccesses++;
            
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"coinSoundEffect" ofType:@"wav"];
//            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
            [audioPlayer play];
            
            [self shuffleBoardPieces];
            [self generateRandomDescriptorText];
            
            //[gameTimer invalidate];
            
            _timerCount +=1;
            self.timerBar.progress +=.1;
            
//            if(self.scoreCount<20) _timerCount +=6;
//            else if(self.scoreCount<50) _timerCount +=5;
//            else if(self.scoreCount<80) _timerCount +=4;
//            else if(self.scoreCount<500) _timerCount +=3;
//            else if(self.scoreCount>=500) _timerCount +=2;
            
            if (_timerCount>61) {
                _timerCount = 61;
            }
            
//            if(self.scoreCount<20) [self startTimerCountdown:6];
//            else if(self.scoreCount<50) [self startTimerCountdown:5];
//            else if(self.scoreCount<150) [self startTimerCountdown:4];
//            else if(self.scoreCount<500) [self startTimerCountdown:3];
//            else if(self.scoreCount<1000) [self startTimerCountdown:2];
//            else if(self.scoreCount>=1000) [self startTimerCountdown:1];
          
            
            [self invertBackgroundColor];
        }
        else{
            //self.scoreCount-=2;
            //[self updateScoreLabel];
            [gameTimer invalidate];
            gameTimer =nil;
            //self.numberOfConsecutiveSuccesses=0;
            self.isGameOver = YES;
            NSLog(@"GAME OVER MOFO");
            
            GameOverVC *gameOver = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverScreen"];
            [self presentViewController:gameOver animated:YES completion:nil];
            gameOver.scoreTextField.text = [NSString stringWithFormat:@"%d", self.scoreCount];
        }
    }
}

- (void)shuffleBoardPieces{
    
    for (int i=0; i<numberOfRows; i++) {
        for (int j=0; j<numberOfColumns; j++) {
            boardPiece *newPiece = [boardPiece generateRandomGamePiece];
            boardPieceGridArray[i][j] = newPiece;
            
            self.theNewImage =[UIImage imageNamed:newPiece.pieceImage];
            
            UIButton* newButton = buttonGridArray[i][j];
            [newButton setImage:self.theNewImage forState:UIControlStateNormal];
        }
    }
    
    
    
//    for(int i = 0;i<[_boardPieceGridArray count];i++){
//        boardPiece *newPiece = [boardPiece generateRandomGamePiece];
//        [_boardPieceGridArray replaceObjectAtIndex:i withObject:newPiece];
//        
//        
//        self.theNewImage = [UIImage imageNamed:newPiece.pieceImage];
//        
//        UIButton* newButton = [self.buttonGridArray objectAtIndex:i];
//        [newButton setImage:self.theNewImage forState:UIControlStateNormal];
//    }
    
}

-(UIButton*)getGamePieceButton:(NSInteger)atRow andColumn:(NSInteger)atColumn{
    return buttonGridArray[atRow][atColumn];
}
-(boardPiece*)getGameBoardPiece:(NSInteger)atRow andColumn:(NSInteger)atColumn{
    return boardPieceGridArray[atRow][atColumn];
}


- (void)startTimerCountdown:(int) counts{
    _timerCount=counts;
//    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownTimer:) userInfo:nil repeats:YES];
//    _timerTextLabel.text=[NSString stringWithFormat:@"%d",_timerCount];
    
    self.timerBar.progress = .5f;
    gameTimer = [NSTimer scheduledTimerWithTimeInterval: (1.0f/60)
                                                 target: self
                                               selector: @selector(updateTimerBar)
                                               userInfo: nil
                                                repeats: YES];

    
}

- (void) updateTimerBar {
    if(self.timerBar.progress >0.0f){
        if(self.scoreCount<20)self.timerBar.progress -= .1f/100;
        else if(self.scoreCount<50)self.timerBar.progress -= .1f/90;
        else if(self.scoreCount<150)self.timerBar.progress -= .1f/80;
        else if(self.scoreCount<500)self.timerBar.progress -= .1f/70; //***
        else if(self.scoreCount<1000)self.timerBar.progress -= .1f/60;
        else if(self.scoreCount>=1000)self.timerBar.progress -= .1f/85;





    }
    else if (self.timerBar.progress <=0.0){
        [gameTimer invalidate];
        GameOverVC *gameOver = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverScreen"];
        [self presentViewController:gameOver animated:YES completion:nil];
        gameOver.scoreTextField.text = [NSString stringWithFormat:@"%d", self.scoreCount];
    }
}

- (void)countdownTimer:(NSTimer *) theTimer{
    _timerCount--;
//    if (_timerCount<=10) {
//        _timerTextLabel.textColor=[UIColor redColor];
//    }
    _timerTextLabel.text=[NSString stringWithFormat:@"%d",_timerCount];
    if(_timerCount == 0){
        [gameTimer invalidate];
        gameTimer = nil;
        self.isGameOver = YES;
        NSLog(@"GAME OVER");
        
        
        GameOverVC *gameOver = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverScreen"];
        [self presentViewController:gameOver animated:YES completion:nil];
        gameOver.scoreTextField.text = [NSString stringWithFormat:@"%d", self.scoreCount];
        
        
        //[self endGameNow]; call method to end game and prevent any actions and finalize player score, play again window pop up
    }
}

- (void)generateRandomDescriptorText{
    //self.randomPieceIndex = arc4random_uniform([self.boardPieceGridArray count]);
    
    
    //self.randomBoardPiece = [self.boardPieceGridArray objectAtIndex:self.randomPieceIndex];
    self.randomBoardPiece = boardPieceGridArray[arc4random_uniform(numberOfRows)][arc4random_uniform(numberOfColumns)];
    
    
    self.descriptorShape=self.randomBoardPiece.pieceShape; //bc just 1 shape right now
    
    self.descriptorColor=self.randomBoardPiece.pieceColor;
    
    self.descriptorTextColor=arc4random_uniform(7)+1;
    
    if (self.descriptorTextColor==1) {self.pieceDescriptorText.textColor=[UIColor blueColor];}
    if (self.descriptorTextColor==2) {self.pieceDescriptorText.textColor=[UIColor greenColor];}
    if (self.descriptorTextColor==3) {self.pieceDescriptorText.textColor=[UIColor orangeColor];}
    if (self.descriptorTextColor==4) {self.pieceDescriptorText.textColor=[UIColor magentaColor];}
    if (self.descriptorTextColor==5) {self.pieceDescriptorText.textColor=[UIColor purpleColor];}
    if (self.descriptorTextColor==6) {self.pieceDescriptorText.textColor=[UIColor redColor];}
    if (self.descriptorTextColor==7) {self.pieceDescriptorText.textColor=[UIColor yellowColor];}
    
    if (self.descriptorColor==1) {self.colorPrefix=@"BLUE";}
    if (self.descriptorColor==2) {self.colorPrefix=@"GREEN";}
    if (self.descriptorColor==3) {self.colorPrefix=@"ORANGE";}
    if (self.descriptorColor==4) {self.colorPrefix=@"PINK";}
    if (self.descriptorColor==5) {self.colorPrefix=@"PURPLE";}
    if (self.descriptorColor==6) {self.colorPrefix=@"RED";}
    if (self.descriptorColor==7) {self.colorPrefix=@"YELLOW";}
    
    if (self.descriptorShape==1) {self.shapeSuffix=@" PILL";}
    if (self.descriptorShape==2) {self.shapeSuffix=@" TABLET";}
    if (self.descriptorShape==3) {self.shapeSuffix=@" CIRCLE";}
    
    self.pieceDescriptorText.text = [self.colorPrefix stringByAppendingString:self.shapeSuffix];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
