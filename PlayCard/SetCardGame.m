//
//  SetCardGame.m
//  PlayCard
//
//  Created by han on 15/2/25.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "SetCardGame.h"

@implementation SetCardGame

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [self initWithCardCount:count
                         usingDeck:deck
                     usingMatchNum:3];
    return self;
}

@end
