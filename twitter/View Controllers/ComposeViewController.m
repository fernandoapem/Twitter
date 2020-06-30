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
@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)cancelButton:(id)sender;
- (IBAction)tweetButton:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
