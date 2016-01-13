//
//  GameOverVC.m
//  Final App Project
//
//  Created by James Chen on 7/25/14.
//  Copyright (c) 2014 James Chen & Oscar GM. All rights reserved.
//

#import "GameOverVC.h"
#import "ViewController.h"

@interface GameOverVC ()

@end

@implementation GameOverVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (IBAction)playAgainButtonMethod:(id)sender {
    ViewController *restartGameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainGameBoardVC"];
    [self presentViewController:restartGameVC animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
