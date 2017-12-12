//
//  GameModel.m
//  2PlayerMath
//
//  Created by Daniel Grosman on 2017-11-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _leftValue = arc4random_uniform(20) +1;
        _rightValue = arc4random_uniform(20) +1;
        _answer = _leftValue + _rightValue;
    }
    return self;
}

-(void)generateQuestion {
    self.leftValue = arc4random_uniform(20) +1;
    self.rightValue = arc4random_uniform(20) +1;
    self.answer = self.leftValue + self.rightValue;
}

@end
