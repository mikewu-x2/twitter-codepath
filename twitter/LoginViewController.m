//
//  LoginViewController.m
//  twitter
//
//  Created by Michael Wu on 9/23/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LoginViewController
- (IBAction)onLogin:(UIButton *)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            NSLog(@"Login view welcome %@", user.name);
            // Modally present tweets
            [self presentViewController:[[TweetsViewController alloc] init] animated:YES completion:nil];
        } else {
            // Present error
            NSLog(@"Login view fail");
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
