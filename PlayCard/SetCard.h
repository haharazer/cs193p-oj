//
//  SetCard.h
//  PlayCard
//
//  Created by han on 15/2/25.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shading;

@end

static const NSUInteger shadingCount = 3;
static const NSUInteger colorCount = 3;
static const NSUInteger shapeCount = 3;
static const NSUInteger maxRank = 3;
