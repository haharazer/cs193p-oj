//
//  ActionDescription.h
//  PlayCard
//
//  Created by han on 15/2/26.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionDescription : NSObject

@property (nonatomic) BOOL isMatchAction;
@property (nonatomic) BOOL matched;
@property (strong, nonatomic) NSArray *cards;
@property (nonatomic) NSInteger points;

@end
