//
//  CalcScene.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import <MediaPlayer/MediaPlayer.h>

@interface CalcScene : CCLayer <UITextViewDelegate, UITextFieldDelegate> {
	
	BOOL                    touched;
    
    CCLabelBMFont           *labelBottom;
    
    UITextField             *task_01Field;
    UITextField             *task_02Field;
    UITextField             *task_03Field;
    
    CCLabelTTF              *treatment_threshold_calculated;
    CCLabelTTF              *your_threshold_calculated;
}

@property						BOOL				touched;

+ (id) scene;

@end
