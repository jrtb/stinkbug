//
//  iphoneIntroNode.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import <MediaPlayer/MediaPlayer.h>

@interface iphoneIntroNode : CCLayer {
	
	BOOL                    touched;
	CCSprite                *back;

}

@property						BOOL				touched;

+ (id) scene;

@end
