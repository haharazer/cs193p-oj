//
//  PlayingCard.m
//  PlayCard
//
//  Created by han on 15/2/19.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit?_suit:@"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♣️", @"♠️", @"♥️", @"♦️"];
}

+ (NSArray *)rankString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
             @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankString] count] - 1;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankString];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;

    BOOL rankEqual = YES;
    BOOL suitEqual = YES;
    for (PlayingCard *otherCard in otherCards) {
        if (self.rank != otherCard.rank) {
            rankEqual = NO;
        }
        if (![self.suit isEqualToString:otherCard.suit])
        {
            suitEqual = NO;
        }
    }
    if (rankEqual) {
        score += 4;
    }
    if (suitEqual) {
        score += 16;
    }
    return score;
}

@end
