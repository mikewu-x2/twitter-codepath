//
//  ComposeViewController.m
//  twitter
//
//  Created by Michael Wu on 9/25/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"

@interface ComposeViewController ()
@property (nonatomic, strong) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UITextField *tweetTextField;
@end

@implementation ComposeViewController

- (id) initWithTweet: (Tweet *)tweet {
    
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        _tweet = tweet;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = self.tweet.user;
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.usernameLabel.text = user.name;
    self.userHandleLabel.text = user.screenname;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelTap)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetTap)];
    
    self.navigationItem.rightBarButtonItem = tweetButton;
    
    self.navigationItem.title = @"Compose";
}

- (void)onCancelTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweetTap {
    NSLog(@"tweeting");
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    // Are we replying?
    if (self.tweet != nil) {
        dictionary[@"in_reply_to_status_id"] = self.tweet.tweetId;
    }

    [[TwitterClient sharedInstance] compose:self.tweetTextField.text params:dictionary completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"Tweet Success");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"Tweet Error");
        }
    }];
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
