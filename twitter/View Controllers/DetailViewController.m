//
//  DetailViewController.m
//  twitter
//
//  Created by Fernando Arturo Perez on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoritedButton;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData:self.tweet];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapFavorite:(id)sender {

    if(self.tweet.favorited==NO){
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            
        }
        else{
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            [self refreshData:self.tweet];
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    }
    else
    {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                self.tweet.favorited = NO;
                self.tweet.favoriteCount -= 1;
                [self refreshData:self.tweet];
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
}

- (IBAction)didTapRetweet:(id)sender {
        if(self.tweet.retweeted==NO){
     [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
           if(error){
                NSLog(@"Error retweet tweet: %@", error.localizedDescription);
               
           }
           else{
               self.tweet.retweeted = YES;
               self.tweet.retweetCount += 1;
               [self refreshData:self.tweet];
               NSLog(@"Successfully retweet the following Tweet: %@", tweet.text);
               
           }
       }];
    }
    else
    {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
              if(error){
                   NSLog(@"Error unretweet tweet: %@", error.localizedDescription);
                  
              }
              else{
                  self.tweet.retweeted = NO;
                  self.tweet.retweetCount -= 1;
                  [self refreshData:self.tweet];
                  NSLog(@"Successfully unretweet the following Tweet: %@", tweet.text);
                  
              }
          }];
        
    }
    
}
- (void) refreshData:(Tweet *) tweet
{
    self.tweet = tweet;
        
    self.nameLabel.text = self.tweet.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    NSString *profilePictureURL = self.tweet.user.profilePicture;
    NSURL *profilePicture = [NSURL URLWithString:profilePictureURL];
    self.profilePicture.image = nil;
    [self.profilePicture setImageWithURL:profilePicture];
    self.dateLabel.text = self.tweet.longDate;
    NSLog(@"%@",self.tweet.longDate);
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.tweetLabel.text = self.tweet.text;
   
    
    [self.favoritedButton setSelected:self.tweet.favorited];
    [self.retweetButton setSelected:self.tweet.retweeted];

}
@end
