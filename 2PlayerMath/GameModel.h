//
//  GameModel.h
//  2PlayerMath
//
//  Created by Daniel Grosman on 2017-11-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (nonatomic, assign) NSInteger leftValue;
@property (nonatomic, assign) NSInteger rightValue;
@property (nonatomic, assign) NSInteger answer;

- (void) generateQuestion;


@end
