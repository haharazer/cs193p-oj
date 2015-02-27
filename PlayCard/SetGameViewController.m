//
//  SetGameViewController.m
//  PlayCard
//
//  Created by han on 15/2/26.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "HistoryViewController.h"
#import "ActionDescription.h"

@interface SetGameViewController ()

@property (strong, nonatomic)SetCardGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) NSDictionary *shapeDict;

@end

@implementation SetGameViewController

- (SetCardGame *)game
{
    if (!_game) {
        _game = [[SetCardGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSDictionary *)shapeDict
{
    if (!_shapeDict) {
        _shapeDict = @{
                       @0:@"▲",
                       @1:@"●",
                       @2:@"■",
                       };
    }
    return _shapeDict;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %d", (int)self.game.score];
}

- (NSAttributedString *)titleForCard:(SetCard *)card
{
    NSMutableString *content = [[NSMutableString alloc] init];
    NSString *shape = [self.shapeDict objectForKey:[NSNumber numberWithInteger:card.shape]];
    for (NSUInteger i = 0; i < card.rank; i++) {
        [content appendString:shape];
    }
    UIColor *color = [[UIColor alloc] init];
    switch (card.color) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor blueColor];
            break;
        case 2:
            color = [UIColor greenColor];
            break;
        default:
            break;
    }
    NSAttributedString *res = [[NSAttributedString alloc] initWithString:content
                                                              attributes:@{
                                                                           NSForegroundColorAttributeName:color
                                                                           }];
    return res;
}

- (UIImage *)imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"cardselected": @"cardfront"];
}

- (void)restartGame:(NSUInteger)matchNum
{
    self.game = [[SetCardGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
    [self updateUI];
}


- (IBAction)clickCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)restart:(UIButton *)sender
{
    self.game = [[SetCardGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
    [self updateUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SetGameHistory"]) {
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
        SetCard *card = [desc.cards firstObject];
        res = [self titleForCard:card];
    }
    return res;
}

- (NSAttributedString *)getMatchedDescreption:(NSArray *)cards withPoint:(NSInteger)points
{
    NSMutableAttributedString *actionDesc = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
    for (SetCard *card in cards)
    {
        [actionDesc appendAttributedString:[self titleForCard:card]];
        [actionDesc appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    NSString *tmpStr = [[NSString alloc] initWithFormat:@"for %d points.", (int)points];
    [actionDesc appendAttributedString:[[NSAttributedString alloc] initWithString:tmpStr]];
    return actionDesc;
}

- (NSAttributedString *)getDisMatchedDescription:(NSArray *)cards withPoint:(NSInteger) points
{
    NSMutableAttributedString *actionDesc = [[NSMutableAttributedString alloc] initWithString:@""];
    for (SetCard *card in cards)
    {
        [actionDesc appendAttributedString:[self titleForCard:card]];
        [actionDesc appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    NSString *tmpStr = [[NSString alloc] initWithFormat:@"don’t match! %d point penalty!", (int)points];
    [actionDesc appendAttributedString:[[NSAttributedString alloc] initWithString:tmpStr]];
    return actionDesc;
}

@end
