//
//  ContentScene.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import "CCUIViewWrapper.h"

#import <MediaPlayer/MediaPlayer.h>

@interface ContentScene : CCLayer <UIGestureRecognizerDelegate, UIWebViewDelegate, UIAlertViewDelegate> {
	
	BOOL                    touched;
    
    CCLabelBMFont           *labelBottom;
    
    float                   iphoneAddY;
    
    UIWebView               *htmlView;
    CCUIViewWrapper         *viewWrapper;
    
    float                   neutral;
    
    NSMutableArray          *dots;
    
    NSString                *fileName;
    
}

@property						BOOL				touched;

+ (id) scene;

@end
