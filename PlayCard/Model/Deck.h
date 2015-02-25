//
//  Deck.h
//  PlayCard
//
//  Created by han on 15/2/19.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
