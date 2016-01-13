//
//  GameOverVC.h
//  Final App Project
//
//  Created by James Chen on 7/25/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;

@property(nonatomic) int score;

@end
