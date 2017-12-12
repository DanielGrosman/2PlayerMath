//
//  Player.h
//  2PlayerMath
//
//  Created by Daniel Grosman on 2017-11-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, assign) NSInteger numberOfLives;
@property (nonatomic, assign) NSInteger score;

- (void) loseLife;
- (void) calculateScore;

@end
