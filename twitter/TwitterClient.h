//
//  TwitterClient.h
//  twitter
//
//  Created by Michael Wu on 9/23/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)retweet:(NSString *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion;
- (void)addFavorite:(NSString *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion;
- (void)compose:(NSString *)tweet params:(NSDictionary *)params completion:(void (^)(Tweet *tweet, NSError *error))completion;
@end
