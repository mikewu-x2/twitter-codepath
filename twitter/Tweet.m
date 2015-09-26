//
//  Tweet.m
//  twitter
//
//  Created by Michael Wu on 9/24/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        
        self.tweetId = dictionary[@"id"];
        self.user  = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString  = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        
        if (dictionary[@"retweet_count"] != nil) {
            self.retweetCount = dictionary[@"retweet_count"];
        } else {
            self.retweetCount = 0;
        }
        
        if (dictionary[@"favorite_count"] != nil) {
            self.faveCount = dictionary[@"favorite_count"];
        } else {
            self.faveCount = 0;
        }

        //self.isRetweet = [dictionary[@"retweeted"] boolValue];
        if (dictionary[@"retweeted_status"] != nil) {
            self.retweet = [[Tweet alloc] initWithDictionary:dictionary[@"retweeted_status"]];
        } else {
            self.retweet = nil;
        }
    }
    
    return self;
    
}

+ (NSArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in dictionaries) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
