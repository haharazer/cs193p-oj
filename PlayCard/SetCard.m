//
//  SetCard.m
//  PlayCard
//
//  Created by han on 15/2/25.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSInteger)match:(NSArray *)chosenCards
{
    NSInteger score = 0;
    if ([chosenCards count] != 3) {
        return score;
    }
    
//    NSMutableSet *shadingSet = [[NSMutableSet alloc] init];
    NSMutableSet *shapeSet = [[NSMutableSet alloc] init];
    NSMutableSet *colorSet = [[NSMutableSet alloc] init];
    NSMutableSet *rankSet = [[NSMutableSet alloc] init];

    for (SetCard *card in chosenCards)
    {
//        NSNumber *shading = [NSNumber numberWithInteger:card.shading];
        NSNumber *shape = [NSNumber numberWithInteger:card.shape];
        NSNumber *color = [NSNumber numberWithInteger:card.color];
        NSNumber *rank = [NSNumber numberWithInteger:card.rank];
//        [shadingSet addObject:shading];
        [shapeSet addObject:shape];
        [colorSet addObject:color];
        [rankSet addObject:rank];
    }
    if (([shapeSet count] == 1 || [shapeSet count] == 3)
        && ([colorSet count] == 1 || [colorSet count] == 3)
        && ([rankSet count] == 1 || [rankSet count] == 3))
    {
        score = 10;
    }
    return score;
}

@end
