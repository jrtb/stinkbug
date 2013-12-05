//
//  MenuScene.h
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import <MessageUI/MessageUI.h>

#import <MediaPlayer/MediaPlayer.h>

@interface MenuScene : CCLayer <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate> {
	
	BOOL                    touched;
    
    CCLabelBMFont           *labelBottom;
    
    UIImage                 *image;
}

@property                       BOOL				touched;

@property (strong, nonatomic) UIImage *image;

+ (id) scene;

@end
