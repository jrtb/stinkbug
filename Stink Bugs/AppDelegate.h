//
//  AppDelegate.h
//  asdasd
//
//  Created by jrtb on 11/13/13.
//  Copyright NC State University 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define IPAD 0
#define IPHONE 1

#define INTRO 151
#define MENU 152

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
    
    BOOL                isRetina;
    int                 screenToggle;
	int					deviceMode;

}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@property BOOL isRetina;
@property int screenToggle;
@property int deviceMode;

- (void) replaceTheScene;

@end