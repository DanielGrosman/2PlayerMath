//
//  ViewController.m
//  2PlayerMath
//
//  Created by Daniel Grosman on 2017-11-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "ViewController.h"
#import "Player.h"
#import "GameModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *player1Score;
@property (weak, nonatomic) IBOutlet UILabel *player2Score;
@property (weak, nonatomic) IBOutlet UILabel *player1Lives;
@property (weak, nonatomic) IBOutlet UILabel *player2Lives;
@property (weak, nonatomic) IBOutlet UILabel *userQuestion;
@property (weak, nonatomic) IBOutlet UILabel *answerInput;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;

@property (nonatomic) GameModel *gameModel;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, strong) NSArray<Player*>*players;
@property (nonatomic, strong) Player *currentPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.currentIndex = 0;
  [self setup];
}

- (void) setup {
  self.players = @[[[Player alloc] init], [[Player alloc] init]];
  self.gameModel = [[GameModel alloc] init];
  [self updatePlayerLivesLabels];
  [self updateScoreLabels];
  [self updateQuestionLabel];
  [self updateCorrectLabel:@"" color:[UIColor clearColor]];
}

- (void)switchPlayer {
  self.currentIndex = [self nextIndex];
}

- (NSUInteger)nextIndex {
  return self.currentIndex == 0 ? 1: 0;
}

- (void)updateString:(NSString *)string {
  self.answerInput.text = [NSString stringWithFormat:@"%@%@", self.answerInput.text, string];
}

- (IBAction)buttonTapped:(UIButton *)sender {
  NSString *title = [sender titleForState:UIControlStateNormal];
  [self updateString:title];
}

- (void)updateScoreLabels {
  self.player1Score.text=[NSString stringWithFormat:@"Player 1 Score: %ld",self.players[0].score];
  self.player2Score.text=[NSString stringWithFormat:@"Player 2 Score: %ld",self.players[1].score];
}

- (void)updateQuestionLabel {
  self.userQuestion.text = [NSString stringWithFormat:@"Player %ld: %ld + %ld", self.currentIndex+1, self.gameModel.leftValue, self.gameModel.rightValue];
}

- (void)updateCorrectLabel:(NSString *)message color:(UIColor *)color {
  self.correctLabel.text = message;
  self.correctLabel.textColor = color;
  [UIView animateWithDuration:1.0 animations:^(void){
    self.correctLabel.alpha = 1;
    self.correctLabel.alpha = 0;
  }];
}

- (void)updatePlayerLivesLabels {
  self.player1Lives.text = [NSString stringWithFormat:@"Player 1 Lives: %ld",self.players[0].numberOfLives];
  self.player2Lives.text=[NSString stringWithFormat:@"Player 2 Lives: %ld",self.players[1].numberOfLives];
}

- (Player *)currentPlayer {
  return self.players[self.currentIndex];
}

- (void)checkEndGame {
  if (self.currentPlayer.numberOfLives < 1) {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over!" message:[NSString stringWithFormat:@"Player %@ Won the Game\nWould you like to play again?", @([self nextIndex])] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *restart = [UIAlertAction actionWithTitle:@"Restart Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {[self setup];}];
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"Quit Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {exit(0);}];
    [alert addAction:restart];
    [alert addAction:quit];
    [self presentViewController: alert animated: YES completion: nil];
  }
}

- (IBAction)pressEnter:(id)sender {
  
  NSInteger answerProvidedByUser = [self.answerInput.text integerValue];
  BOOL isCorrect = answerProvidedByUser == self.gameModel.answer;
  
  if (isCorrect) {
    self.currentPlayer.score++;
    [self updateCorrectLabel:@"Correct!" color:[UIColor greenColor]];
    [self updateScoreLabels];
  } else {
    self.currentPlayer.numberOfLives --;
    [self updateCorrectLabel:@"Incorrect!" color:[UIColor redColor]];
    [self checkEndGame];
    [self updatePlayerLivesLabels];
  }
  [self switchPlayer];
  [self.gameModel generateQuestion];
  [self updateQuestionLabel];
  self.answerInput.text = @"";
}

@end
