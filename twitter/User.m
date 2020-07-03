//
//  User.m
//  twitter
//
//  Created by Fernando Arturo Perez on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.profileBanner = dictionary[@"profile_banner_url"];
        self.followersCount = [dictionary[@"followers_count"] intValue];
        self.followingCount = [dictionary[@"friends_count"] intValue];
        self.tweetCount = [dictionary[@"statuses_count"] intValue];
        self.likeCount = [dictionary[@"favourites_count"] intValue];
        
    }
    return self;
}
+(User *) userWithArray:(NSDictionary *)dictionary
{
    User *user = [[User alloc] initWithDictionary:dictionary];
    return user;
}

@end
