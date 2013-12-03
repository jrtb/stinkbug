//
//  iphoneCalcScene.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import <MediaPlayer/MediaPlayer.h>

@interface iphoneCalcScene : CCLayer {
	
	BOOL                    touched;
    
    float                   iphoneAddY;
    
    CCLabelBMFont           *labelBottom;
}

@property						BOOL				touched;

+ (id) scene;

@end
