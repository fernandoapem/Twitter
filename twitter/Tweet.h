//
//  Tweet.h
//  twitter
//
//  Created by Fernando Arturo Perez on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *createdAtString;
@property (nonatomic) int favoriteCount;
@property (nonatomic) int retweetCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) BOOL retweeted;
@property (nonatomic, strong) User *user;
 
//in case of retweet
@property (nonatomic, strong) User *retweetedByUser;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
