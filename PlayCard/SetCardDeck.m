//
//  SetCardDeck.m
//  PlayCard
//
//  Created by han on 15/2/25.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        for (NSUInteger shape = 0; shape < shapeCount; shape++)
        {
            for (NSUInteger shading = 0; shading < shadingCount; shading++) {
                for (NSUInteger color = 0; color < colorCount; color++) {
                    for (NSUInteger rank = 1; rank <= maxRank; rank++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = rank;
                        card.shape = shape;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
