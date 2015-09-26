//
//  ComposeViewController.h
//  twitter
//
//  Created by Michael Wu on 9/25/15.
//  Copyright © 2015 Michael Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface ComposeViewController : UIViewController
- (id) initWithTweet: (Tweet *)tweet;
@end
