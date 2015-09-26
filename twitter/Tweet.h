//
//  Tweet.h
//  twitter
//
//  Created by Michael Wu on 9/24/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Tweet *retweet;
@property (nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, strong) NSNumber *faveCount;
@property (nonatomic, strong) NSNumber *favoriteCount;
@property (nonatomic) BOOL isUserFave;
@property (nonatomic) BOOL isUserRetweet;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)tweetsWithArray:(NSArray *)dictionaries;
@end
