//
//  DetailViewController.h
//  twitter
//
//  Created by Fernando Arturo Perez on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic,strong) Tweet *tweet;
- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapFavorite:(id)sender;


@end

NS_ASSUME_NONNULL_END
