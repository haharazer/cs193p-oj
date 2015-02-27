//
//  HistoryViewController.m
//  PlayCard
//
//  Created by han on 15/2/26.
//  Copyright (c) 2015年 han. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController


- (void)setHistory:(NSArray *)history
{
    _history = history;
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    self.historyTextView.attributedText = [[NSAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *str in self.history)
    {
        [text appendAttributedString: str];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r\n"]];
    }
    self.historyTextView.attributedText = text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
