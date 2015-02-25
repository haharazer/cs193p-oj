//
//  PlayingCard.h
//  PlayCard
//
//  Created by han on 15/2/19.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
