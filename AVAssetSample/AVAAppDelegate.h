//
//  AVAAppDelegate.h
//  AVAssetSample
//
//  Created by Mahesh on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVARootViewController;

@interface AVAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)AVARootViewController *rootViewController;

@end
