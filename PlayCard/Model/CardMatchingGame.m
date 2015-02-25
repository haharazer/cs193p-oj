//
//  CardMatchingGame.m
//  PlayCard
//
//  Created by han on 15/2/19.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)actionDescribeArray
{
    if (!_actionDescribeArray) {
        _actionDescribeArray = [[NSMutableArray alloc] init];
    }
    return _actionDescribeArray;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                    usingMatchNum:(NSUInteger)matchNum
{
    self = [super init];
    
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
        self.matchNum = matchNum;
    }
    
    return self;
}

static const NSUInteger DEFAULT_MATCH_NUM = 2;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [self initWithCardCount:count usingDeck:deck usingMatchNum:DEFAULT_MATCH_NUM];
    return self;
}



static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen)
        {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        }
        else
        {
            NSString *actionDesc = @"";
            [self.chosenCards addObject:card];
            if ([self.chosenCards count] == self.matchNum + 1) {
                Card *firstObject = [self.chosenCards firstObject];
                firstObject.chosen = NO;
                [self.chosenCards removeObjectAtIndex:0];
            }
            if ([self.chosenCards count] == self.matchNum)
            {
                NSInteger matchScore = [card match:self.chosenCards];
                if (matchScore)
                {
                    NSInteger points = matchScore * MATCH_BONUS;
                    self.score += points;
                    actionDesc = @"Matched ";
                    for (Card *chosenCard in self.chosenCards)
                    {
                        chosenCard.matched = YES;
                        actionDesc = [actionDesc stringByAppendingString:chosenCard.contents];
                        actionDesc = [actionDesc stringByAppendingString:@" "];
                    }
                    actionDesc = [actionDesc stringByAppendingFormat:@"for %d points.", (int)points];
                    self.chosenCards = [[NSMutableArray alloc] init];
                }
                else
                {
                    self.score -= MISMATCH_PENALTY;
                    actionDesc = @"";
                    for (Card *chosenCard in self.chosenCards)
                    {
                        actionDesc = [actionDesc stringByAppendingString:chosenCard.contents];
                        actionDesc = [actionDesc stringByAppendingString:@" "];
                    }
                    actionDesc = [actionDesc stringByAppendingFormat:@"don’t match! %d point penalty!", MISMATCH_PENALTY];
                }
            }
            else
            {
                actionDesc = card.contents;
            }
            self.score -= COST_TO_CHOSE;
            card.chosen = YES;
            [self.actionDescribeArray addObject:actionDesc];
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return [self.cards objectAtIndex:index];
}

@end
