//
//  User.h
//  twitter
//
//  Created by Fernando Arturo Perez on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *screenName;
@property (nonatomic,strong) NSString *profilePicture;
@property (nonatomic,strong) NSString *profileBanner;
@property (nonatomic) int followersCount;
@property (nonatomic) int followingCount;
@property (nonatomic) int tweetCount;
@property (nonatomic) int likeCount;

-(instancetype)initWithDictionary: (NSDictionary *) dictionary;
+(User *) userWithArray:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
