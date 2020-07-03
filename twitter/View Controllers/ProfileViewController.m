//
//  ProfileViewController.m
//  twitter
//
//  Created by Fernando Arturo Perez on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerPicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (nonatomic,strong) User *user;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[APIManager shared] getUser: ^(User *user, NSError *error) {
              if(user){
                  self.user = user;
                  [self fetchUser];
              }
          }];
    
}
-(void) fetchUser
{
    self.nameLabel.text = self.user.name;
    NSLog(@"%@",self.user.name);
    self.screenNameLabel.text = self.user.screenName;
    self.followersLabel.text = [NSString stringWithFormat:@"%d", self.user.followersCount];
    self.followingLabel.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.user.likeCount];
    self.tweetLabel.text = [NSString stringWithFormat:@"%d", self.user.tweetCount];
    
    NSString *profilePictureURL = self.user.profilePicture;
    NSURL *profilePicture = [NSURL URLWithString:profilePictureURL];
    self.profilePicture.image = nil;
    [self.profilePicture setImageWithURL:profilePicture];
    
    NSString *profilePictureURL2 = self.user.profileBanner;
    NSURL *profilePicture2 = [NSURL URLWithString:profilePictureURL2];
    self.bannerPicture.image = nil;
    [self.bannerPicture setImageWithURL:profilePicture2];
    
    
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
