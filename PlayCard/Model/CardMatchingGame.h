//
//  CardMatchingGame.h
//  PlayCard
//
//  Created by han on 15/2/19.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                    usingMatchNum:(NSUInteger)matchNum;
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchNum;
@property (strong, nonatomic) NSMutableArray *actionDescribeArray;

@end
