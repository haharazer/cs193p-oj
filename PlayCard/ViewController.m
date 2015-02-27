//
//  ViewController.m
//  PlayCard
//
//  Created by han on 15/2/19.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"
#import "ActionDescription.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *actionDescLabel;

@property (nonatomic) NSUInteger matchNum;

@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)clickCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self.segmentedControl setEnabled:NO];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %d", (int)self.game.score];
    self.actionDescLabel.attributedText = [self getActionDescriptionString:[self.game.actionDescribeArray lastObject]];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"cardfront": @"cardback"];
}

- (void)restartGame:(NSUInteger)matchNum
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                              usingMatchNum:matchNum];
    [self updateUI];
    [self.segmentedControl setEnabled:YES];
}


- (IBAction)restart:(UIButton *)sender
{
    [self restartGame:self.matchNum];
}

- (IBAction)segmentedController:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        self.matchNum = 2;
    }
    else
    {
        self.matchNum = 3;
    }
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]usingDeck:[self createDeck] usingMatchNum:self.matchNum];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CardGameHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            NSMutableArray *history = [[NSMutableArray alloc] init];
            for (ActionDescription *desc in self.game.actionDescribeArray)
            {
                [history addObject:[self getActionDescriptionString:desc]];
            }
            
            HistoryViewController *HistoryViewController = segue.destinationViewController;
            HistoryViewController.history = history;
        }
    }
}

- (NSAttributedString *)getActionDescriptionString:(ActionDescription *)desc
{
    NSAttributedString *res = [[NSAttributedString alloc] init];
    if (desc.isMatchAction) {
        if (desc.matched) {
            res = [self getMatchedDescreption:desc.cards withPoint:desc.points];
        }
        else
        {
            res = [self getDisMatchedDescription:desc.cards withPoint:desc.points];
        }
    }
    else
    {
        Card *card = [desc.cards firstObject];
        res = [[NSAttributedString alloc] initWithString:card.contents];
    }
    return res;
}

- (NSAttributedString *)getMatchedDescreption:(NSArray *)cards withPoint:(NSInteger)points
{
    NSString *actionDesc = @"Matched ";
    for (Card *card in cards)
    {
        actionDesc = [actionDesc stringByAppendingString:card.contents];
        actionDesc = [actionDesc stringByAppendingString:@" "];
    }
    actionDesc = [actionDesc stringByAppendingFormat:@"for %d points.", (int)points];
    return [[NSAttributedString alloc] initWithString:actionDesc];
}

- (NSAttributedString *)getDisMatchedDescription:(NSArray *)cards withPoint:(NSInteger) points
{
    NSString *actionDesc = @"";
    for (Card *card in cards)
    {
        actionDesc = [actionDesc stringByAppendingString:card.contents];
        actionDesc = [actionDesc stringByAppendingString:@" "];
    }
    actionDesc = [actionDesc stringByAppendingFormat:@"don’t match! %d point penalty!", (int)points];
    return [[NSAttributedString alloc] initWithString:actionDesc];
}

@end
