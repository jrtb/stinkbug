//
//  iphoneMenuScene.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import <MediaPlayer/MediaPlayer.h>

@interface iphoneMenuScene : CCLayer {
	
	BOOL                    touched;
    
    CCLabelBMFont           *labelBottom;
    
    float                   iphoneAddY;
}

@property						BOOL				touched;

+ (id) scene;

@end
