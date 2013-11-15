//
//  iphoneContentScene.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import "CCUIViewWrapper.h"

#import <MediaPlayer/MediaPlayer.h>

@interface iphoneContentScene : CCLayer <UIGestureRecognizerDelegate, UIWebViewDelegate> {
	
	BOOL                    touched;
    
    CCLabelBMFont           *labelBottom;
    
    float                   iphoneAddY;
    
    UIWebView               *htmlView;
    CCUIViewWrapper         *viewWrapper;
    
    NSString                *currentPage;
    
    float                   neutral;
}

@property						BOOL				touched;

+ (id) scene;

@end
