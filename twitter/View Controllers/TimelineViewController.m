//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <UITableViewDataSource,UITableViewDelegate,ComposeViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray *tweet;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchHomeTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchHomeTimeline];
    
    
}
- (void)fetchHomeTimeline
{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweet = (NSMutableArray *)tweets;
            [self.tableView reloadData];
            
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.user.name;
                NSLog(@"%@", text);
            }
            NSLog(@"😎😎😎 Successfully loaded home timeline");
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
    composeController.delegate = self;
    
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweetDictionary = self.tweet[indexPath.row];
    
    cell.tweet = tweetDictionary;
    cell.nameLabel.text = cell.tweet.user.name;
    cell.screenNameLabel.text = cell.tweet.user.screenName;
    cell.tweetLabel.text = tweetDictionary.text;
    cell.dateLabel.text = tweetDictionary.createdAtString;
    cell.favoriteLabel.text = [NSString stringWithFormat: @"%d", tweetDictionary.favoriteCount];
    cell.retweetLabel.text = [NSString stringWithFormat: @"%d", tweetDictionary.retweetCount];
    NSString *profilePictureURL = tweetDictionary.user.profilePicture;
    
    NSURL *profilePicture = [NSURL URLWithString:profilePictureURL];
    [cell.profilePicture setImageWithURL:profilePicture];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tweet.count;
}


- (void)didTweet:(nonnull Tweet *)tweet {
    
    [self.tweet insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


@end
