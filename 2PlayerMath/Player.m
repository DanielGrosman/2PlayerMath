//
//  Player.m
//  2PlayerMath
//
//  Created by Daniel Grosman on 2017-11-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)init
{
    self = [super init];
    if (self) {
        _numberOfLives = 3;
        _score = 0;
    }
    return self;
}

- (void)loseLife {
    self.numberOfLives --;
}

- (void)calculateScore {
    self.score ++;
}

@end
