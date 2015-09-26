//
//  TweetCell.m
//  twitter
//
//  Created by Michael Wu on 9/24/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "TweetCell.h"
#import "User.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetImageTopConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    
    if (tweet.retweet != nil) {
        
        User *user = tweet.user;
        self.retweetLabel.text = [NSString stringWithFormat:@"%@ retweeted", user.name];
        
        // Make the retweet the tweet we display
        tweet = tweet.retweet;
        
        self.retweetLabel.hidden = NO;
        self.retweetImageHeightConstraint.constant = 16;
        self.retweetImageTopConstraint.constant = 8;
        
    } else {
        
        self.retweetLabel.hidden = YES;
        self.retweetImageHeightConstraint.constant = 0;
        self.retweetImageTopConstraint.constant = 0;
        
    }
    
    self.tweetLabel.text = tweet.text;
    
    User *user = tweet.user;
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.usernameLabel.text = user.name;
    self.userHandleLabel.text = user.screenname;

    self.dateLabel.text = [tweet.createdAt shortTimeAgoSinceNow];


}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}

@end
