//
//  ViewController.m
//  TicTacToe
//
//  Created by Nick Cowart on 1/12/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



@interface ViewController () <UIAlertViewDelegate>


//@property (nonatomic) int player1Score;
//@property (nonatomic) int player2Score;
@end

@implementation ViewController
{
    int playerTurn;
    
    NSMutableArray * squares;
    NSMutableArray * buttons;
    
    UILabel * scoreLabel1;
    UILabel * scoreLabel2;
    
    int player1Score;
    int player2Score;
    
    NSArray * playerColors;
}

    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    playerColors = @[
                     [UIColor lightGrayColor],
                     [UIColor cyanColor],
                     [UIColor yellowColor]
                     ];
    
    buttons = [@[] mutableCopy];
    
    player1Score = 0;
    
    player2Score = 0;
    
    playerTurn = 1;
    
    squares =  [@[
                 @0,@0,@0,
                 @0,@0,@0,
                 @0,@0,@0
                 ] mutableCopy];
    
    int rowCount = 3;
    int colCount = 3;
    
    
    CGFloat width = 100;
    CGFloat height = 100;
    
    CGFloat padding = -20;
    
    CGFloat fullWidth = (colCount * width) + (rowCount-1) * padding;
    CGFloat fullHeight = (rowCount * height) + (rowCount -1) * padding;
   
    int buttonCount = 0;
    
    
    for (int r = 0; r < rowCount; r++) {

            //        loop per row
        
        for (int c =0; c < colCount; c++) {
        
            //        loop per column
            
            CGFloat x = c * (width + padding) + (SCREEN_WIDTH-fullWidth)/2;
            CGFloat y = r * (height + padding) + (SCREEN_HEIGHT-fullHeight)/2;
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            button.backgroundColor = playerColors [0];
//            [button setTitle:[NSString stringWithFormat:@"%d",buttonCount] forState:UIControlStateNormal];
           
            button.tag = buttonCount;
            
            [button addTarget:self action:@selector(squareTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = height / 2;
            button.alpha = 0.6;
            
            [self.view addSubview:button];
            [buttons addObject:button];
            
            buttonCount++;
            

            
            
//-(void)clearScoreButtonTapped:(UIButton *)button
            
        
            
            
            
            scoreLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 50)];
            
            scoreLabel1.text = [NSString stringWithFormat:@"Player 1: %d",player1Score];
            scoreLabel1.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:scoreLabel1];
            scoreLabel1.backgroundColor = [UIColor cyanColor];
            
            
          
            scoreLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH-20, 50)];
            
            scoreLabel2.text = [NSString stringWithFormat:@"Player 2: %d",player2Score];
            scoreLabel2.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:scoreLabel2];
            scoreLabel2.backgroundColor = [UIColor yellowColor];
            
        }
    }
    
    UIButton * clearScoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT-70, SCREEN_WIDTH-20, 50)];
    //            clearScoreButton.titleLabel.text = @"Clear Score";
    //            clearScoreButton.titleLabel.textColor = [UIColor blackColor];
    
    
    clearScoreButton.backgroundColor = [UIColor redColor];
    [clearScoreButton setTitle:@"Clear Score" forState:UIControlStateNormal];
    [self.view addSubview:clearScoreButton];
    
    [clearScoreButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];

    
    NSLog(@"subview count %@",self.view.subviews);


UIButton * clearBoardButton = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT-125, SCREEN_WIDTH-20, 50)];
//            clearScoreButton.titleLabel.text = @"Clear Score";
//            clearScoreButton.titleLabel.textColor = [UIColor blackColor];


    clearBoardButton.backgroundColor = [UIColor blackColor];
    [clearBoardButton setTitle:@"Clear Board" forState:UIControlStateNormal];
    [self.view addSubview:clearBoardButton];
    clearBoardButton.titleLabel.textColor = [UIColor whiteColor];


    [clearBoardButton addTarget:self action:@selector(clearBoard) forControlEvents:UIControlEventTouchUpInside];


}


-(void)squareTapped:(UIButton *)button {
    
    if ([squares[button.tag] intValue] != 0) {return;}
    
    
    squares[button.tag] = @(playerTurn);
    
    button.backgroundColor = playerColors[playerTurn];
    
    
    playerTurn = (playerTurn == 2) ? 1 : 2;
    NSLog(@"square 1 value %@",squares[0]);

    [self checkForWin];
}

-(void)checkForWin {
    
    NSArray * possibilities = @[
                                // rows
                                @[@0,@1,@2],
                                @[@3,@4,@5],
                                @[@6,@7,@8],
                                
                                // Columns
                                @[@0,@3,@6],
                                @[@1,@4,@7],
                                @[@2,@5,@8],
                                
                                // diagnols
                                @[@0,@4,@8],
                                @[@2,@4,@6],
                                ];
    
    for (NSArray * possibility in possibilities) {
        
        [self checkPossibility:possibility withPlayer:1];
        [self checkPossibility:possibility withPlayer:2];
        
            
        
   
    }

    
}

-(void)checkPossibility:(NSArray *)possibility withPlayer:(int)player {
    
        
        
        BOOL playerInSquare1 = ([squares[[possibility[0] intValue]] intValue] == player);
        BOOL playerInSquare2 = ([squares[[possibility[1] intValue]] intValue] == player);
        BOOL playerInSquare3 = ([squares[[possibility[2] intValue]] intValue] == player);
        
        
        if (playerInSquare1 && playerInSquare2 && playerInSquare3) {
            
            // player 1 won
            NSLog(@"Player %d Won",player);
            
            if (player == 1){
                player1Score++;
                scoreLabel1.text = [NSString stringWithFormat:@"Player 1: %d",player1Score];
            }
            
            if (player == 2) {
                player2Score++;
                scoreLabel2.text = [NSString stringWithFormat:@"Player 2: %d",player2Score];
                
            }
            
            NSString * message = [NSString stringWithFormat:@"Player %d Won", player];
            
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Winner" message:message delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles: nil];
            
            [alertView show];
        }
    
}

-(void)clearBoard{
    
    //    square titles
    for (UIButton * button  in buttons) {
        
        button.backgroundColor = [UIColor lightGrayColor];
        //        [button setTitle:@"" forState:UIControlStateNormal];
    }
    
    playerTurn = 1;
    
    squares =  [@[
                  @0,@0,@0,
                  @0,@0,@0,
                  @0,@0,@0
                  ] mutableCopy];
}

-(void)reset{
    
    scoreLabel1.text = [NSString stringWithFormat:@"Player 1:0"];
    
    scoreLabel2.text = [NSString stringWithFormat:@"Player 2:0"];
   
    player1Score = 0;
    
    player2Score = 0;

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
//    square titles
    for (UIButton * button  in buttons) {

        button.backgroundColor = [UIColor lightGrayColor];
//        [button setTitle:@"" forState:UIControlStateNormal];
    }
    
    playerTurn = 1;
    
    squares =  [@[
                  @0,@0,@0,
                  @0,@0,@0,
                  @0,@0,@0
                  ] mutableCopy];
    
    
    NSLog(@"Play Again");
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
