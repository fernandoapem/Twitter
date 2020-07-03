//
//  TweetCell.m
//  twitter
//
//  Created by Fernando Arturo Perez on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "NSDate+DateTools.h"


@implementation TweetCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
- (void) refreshData:(Tweet *) tweet
{
    self.tweet = tweet;
        
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text =  [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    self.dateLabel.text = self.tweet.createdAtString;
    self.favoriteLabel.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
    
    [self.favoritedButton setSelected:self.tweet.favorited];
    [self.retweetButton setSelected:self.tweet.retweeted];
    
    NSString *profilePictureURL = self.tweet.user.profilePicture;
    NSURL *profilePicture = [NSURL URLWithString:profilePictureURL];
    
    self.profilePicture.image = nil;
    [self.profilePicture setImageWithURL:profilePicture];
}
@end
