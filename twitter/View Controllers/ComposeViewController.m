//
//  ComposeViewController.m
//  twitter
//
//  Created by Fernando Arturo Perez on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
@interface ComposeViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)cancelButton:(id)sender;
- (IBAction)tweetButton:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
   // Allow or disallow the new text
    int characterLimit = 280;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update Character Count Label

    // The new text should be allowed? True/False
    return newText.length < characterLimit;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tweetButton:(id)sender {
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error){
        if(tweet)
        {
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else
        {
            NSLog(@"Error posting tweet: %@", error.localizedDescription);
        }   
    }];
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
