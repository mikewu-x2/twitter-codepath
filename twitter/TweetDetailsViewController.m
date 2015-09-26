//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Michael Wu on 9/25/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetImageTopConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *faveCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;

@property (nonatomic, strong) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UIImageView *replyActionView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetActionView;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteActionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@end

@implementation TweetDetailsViewController

- (id) initWithTweet: (Tweet *)tweet {
    
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        _tweet = tweet;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Tweet *tweet = self.tweet;
    
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
    self.faveCountLabel.text = [tweet.faveCount stringValue];
    self.retweetCountLabel.text = [tweet.retweetCount stringValue];
    
    if (tweet.isUserRetweet) {
        [self.retweetActionView setImage:[UIImage imageNamed:@"retweet_active"]];
    }
    
    if (tweet.isUserFave) {
        [self.favoriteActionView setImage:[UIImage imageNamed:@"favorite_active"]];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.dateLabel.text = [formatter stringFromDate:tweet.createdAt];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(onHomeTap)];
    
    self.navigationItem.leftBarButtonItem = homeButton;
    self.navigationItem.title = @"Details";
    
    UITapGestureRecognizer *replyActionRecognizer = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleReplyAction)];
    
    [self.replyActionView addGestureRecognizer:replyActionRecognizer];
    
    UITapGestureRecognizer *retweetActionRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(handleRetweetAction)];
    
    [self.retweetActionView addGestureRecognizer:retweetActionRecognizer];
    
    UITapGestureRecognizer *faveActionRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(handleFaveAction)];
    
    [self.favoriteActionView addGestureRecognizer:faveActionRecognizer];
    
}

- (void)handleReplyAction {
    NSLog(@"Reply");
    
    ComposeViewController *vc = [[ComposeViewController alloc] initWithTweet:self.tweet];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)handleRetweetAction {
    NSLog(@"Retweet");
    [[TwitterClient sharedInstance] retweet:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"Retweet Success");
            [self.retweetActionView setImage:[UIImage imageNamed:@"retweet_active"]];
        } else {
            NSLog(@"Retweet Error");
        }
    }];
}

- (void)handleFaveAction {
    NSLog(@"Fave");
    [[TwitterClient sharedInstance] addFavorite:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"Fave Success");
            [self.favoriteActionView setImage:[UIImage imageNamed:@"favorite_active"]];
        } else {
            NSLog(@"Fave Error");
        }
    }];
}

- (void)onHomeTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
