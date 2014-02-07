//
//  MenuScene.m
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import "MenuScene.h"
//#import "MenuScene.h"
//#import "MenuScene.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

#import "CCUIViewWrapper.h"

//
// Small scene that plays the background music and makes a transition to the Menu scene
//
@implementation MenuScene

@synthesize touched, image;

+(id) scene {
	CCScene *s = [CCScene node];
	id node = [MenuScene node];
	[s addChild:node];
	return s;
}

-(id) init {
	if( ![super init])
		return nil;
    
    printf("menu scene loading\n");
    
	//printf("intro init\n");
    
	touched = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
    CCSprite *back = [self createSpriteRectangleWithSize:CGSizeMake(size.width,size.height)];
    back.color = ccc3(255,255,255);
    back.position = ccp(size.width*0.5,size.height*.5);
    [self addChild:back z:0];
    
    CCSprite *mainBack = [CCSprite spriteWithFile:@"menu_bg-hd.pvr.gz"];
    mainBack.anchorPoint = ccp(0.5,1.0);
    mainBack.opacity = 255*.25;
    mainBack.position = ccp(size.width*.5,size.height);
    [self addChild:mainBack z:2];
    
    CCSprite *brick = [CCSprite spriteWithFile:@"ncsu_brick-hd.pvr.gz"];
    brick.anchorPoint = ccp(0.0,1.0);
    brick.position = ccp(0.0,size.height-0.5);
    [self addChild:brick z:2];
    
    CCSprite *bottom = [CCSprite spriteWithFile:@"bottom_bar-hd.pvr.gz"];
    bottom.anchorPoint = ccp(0.5,0.5);
    bottom.position = ccp(size.width*.5,bottom.contentSize.height*.5);
    [self addChild:bottom z:2];
    
    labelBottom = [CCLabelBMFont labelWithString:@"STINK BUG DECISION AID" fntFile:@"bottom-menu-14-hd.fnt"];
    labelBottom.anchorPoint = ccp(0.5,0.5);
    labelBottom.position = bottom.position;
    [self addChild:labelBottom z:3];
    
    float menuStartY = 390.0/480.0*1024.0;
    float sepY = 38.5/480.0*1024.0;
    
    CCSprite *selected_01 = [CCSprite spriteWithFile:@"button_01-hd.pvr.gz"];
    selected_01.color = ccGRAY;
    
    CCMenuItemSprite *item_01 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_01-hd.pvr.gz"]
                                                        selectedSprite:selected_01
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_01 = [CCMenu menuWithItems:item_01, nil];
    [menu_01 setPosition:ccp(size.width*.5,menuStartY - sepY*0)];
    item_01.tag = 1;
    [self addChild:menu_01 z:2];
    
    CCSprite *selected_02 = [CCSprite spriteWithFile:@"button_02-hd.pvr.gz"];
    selected_02.color = ccGRAY;
    
    CCMenuItemSprite *item_02 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_02-hd.pvr.gz"]
                                                        selectedSprite:selected_02
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_02 = [CCMenu menuWithItems:item_02, nil];
    [menu_02 setPosition:ccp(size.width*.5,menuStartY - sepY*1)];
    item_02.tag = 2;
    [self addChild:menu_02 z:2];
    
    CCSprite *selected_03 = [CCSprite spriteWithFile:@"button_03-hd.pvr.gz"];
    selected_03.color = ccGRAY;
    
    CCMenuItemSprite *item_03 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_03-hd.pvr.gz"]
                                                        selectedSprite:selected_03
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_03 = [CCMenu menuWithItems:item_03, nil];
    [menu_03 setPosition:ccp(size.width*.5,menuStartY - sepY*2)];
    item_03.tag = 3;
    [self addChild:menu_03 z:2];
    
    CCSprite *selected_04 = [CCSprite spriteWithFile:@"button_04-hd.pvr.gz"];
    selected_04.color = ccGRAY;
    
    CCMenuItemSprite *item_04 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_04-hd.pvr.gz"]
                                                        selectedSprite:selected_04
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_04 = [CCMenu menuWithItems:item_04, nil];
    [menu_04 setPosition:ccp(size.width*.5,menuStartY - sepY*3)];
    item_04.tag = 4;
    [self addChild:menu_04 z:2];
    
    CCSprite *selected_05 = [CCSprite spriteWithFile:@"button_05-hd.pvr.gz"];
    selected_05.color = ccGRAY;
    
    CCMenuItemSprite *item_05 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_05-hd.pvr.gz"]
                                                        selectedSprite:selected_05
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_05 = [CCMenu menuWithItems:item_05, nil];
    [menu_05 setPosition:ccp(size.width*.5,menuStartY - sepY*4)];
    item_05.tag = 5;
    [self addChild:menu_05 z:2];
    
    CCSprite *selected_06 = [CCSprite spriteWithFile:@"button_06-hd.pvr.gz"];
    selected_06.color = ccGRAY;
    
    CCMenuItemSprite *item_06 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_06-hd.pvr.gz"]
                                                        selectedSprite:selected_06
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_06 = [CCMenu menuWithItems:item_06, nil];
    [menu_06 setPosition:ccp(size.width*.5,menuStartY - sepY*5)];
    item_06.tag = 6;
    [self addChild:menu_06 z:2];
    
    CCSprite *selected_07 = [CCSprite spriteWithFile:@"button_07-hd.pvr.gz"];
    selected_07.color = ccGRAY;
    
    CCMenuItemSprite *item_07 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_07-hd.pvr.gz"]
                                                        selectedSprite:selected_07
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_07 = [CCMenu menuWithItems:item_07, nil];
    [menu_07 setPosition:ccp(size.width*.5,menuStartY - sepY*6)];
    item_07.tag = 7;
    [self addChild:menu_07 z:2];
    
    CCSprite *selected_08 = [CCSprite spriteWithFile:@"button_08-hd.pvr.gz"];
    selected_08.color = ccGRAY;
    
    CCMenuItemSprite *item_08 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_08-hd.pvr.gz"]
                                                        selectedSprite:selected_08
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_08 = [CCMenu menuWithItems:item_08, nil];
    [menu_08 setPosition:ccp(size.width*.5,menuStartY - sepY*7)];
    item_08.tag = 8;
    [self addChild:menu_08 z:2];
    
    CCSprite *selected_09 = [CCSprite spriteWithFile:@"button_09-hd.pvr.gz"];
    selected_09.color = ccGRAY;
    
    CCMenuItemSprite *item_09 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"button_09-hd.pvr.gz"]
                                                        selectedSprite:selected_09
                                                                target:self
                                                              selector:@selector(buttonAction:)];
    
    CCMenu  *menu_09 = [CCMenu menuWithItems:item_09, nil];
    [menu_09 setPosition:ccp(size.width*.5,menuStartY - sepY*8)];
    item_09.tag = 9;
    [self addChild:menu_09 z:2];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
        
        CCSprite *selected_10 = [CCSprite spriteWithFile:@"camera_button-hd.pvr.gz"];
        selected_10.color = ccGRAY;
        
        CCSprite *selected_10a = [CCSprite spriteWithFile:@"camera_button-hd.pvr.gz"];
        selected_10a.color = ccc3(225, 225, 225);
        
        if (!delegate.isRetina) {
            selected_10.scale = 0.75;
            selected_10a.scale = 0.75;
        }
        
        CCMenuItemSprite *item_10 = [CCMenuItemSprite itemWithNormalSprite:selected_10a
                                                            selectedSprite:selected_10
                                                                    target:self
                                                                  selector:@selector(cameraAction:)];
        
        CCMenu  *menu_10 = [CCMenu menuWithItems:item_10, nil];
        [menu_10 setPosition:ccp(39*2,60*2)];
        [self addChild:menu_10 z:2];
        
    }
    
	return self;
}

- (void) cameraAction: (CCMenu *) sender
{
    printf("cameraAction\n");
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"knock.caf"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Use the camera?" message:@"Would you like to use your device's camera to send a picture to an extension agent?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [[CCDirector sharedDirector] presentViewController:picker animated:YES completion:nil];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //self.imageView.image = chosenImage;
    //image = info[UIImagePickerControllerEditedImage];
    image = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self showEmail];
        
    }];
    
}

- (void) showEmail {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        
        MFMailComposeViewController *picker2 = [[MFMailComposeViewController alloc] init];
        picker2.mailComposeDelegate = self; // very important step if you want feedbacks on what the user did with your email sheet
        //picker2.wantsFullScreenLayout = YES;
        
        //[picker2 setToRecipients:[NSArray arrayWithObject:@""]];
        
        //NSString *emailBody = [NSString stringWithFormat:@""];
        
        NSString *title = [NSString stringWithFormat:@"Stink Bug App picture email submission"];
        
        [picker2 setSubject:title];
        
        [picker2 addAttachmentData:UIImageJPEGRepresentation(image, 1) mimeType:@"image/jpeg" fileName:@"MyFile.jpeg"];
        
        //[picker2 setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
        
        picker2.navigationBar.barStyle = UIBarStyleDefault; // choose your style, unfortunately, Translucent colors behave quirky.
        
        if (picker2 && picker2 != nil) {
            [[CCDirector sharedDirector] presentViewController:picker2 animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Error - this device is not currently setup to use email."
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Error - this device is not currently setup to use email."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
            //socialSent = YES;
			break;
		case MFMailComposeResultFailed:
			break;
			
        default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
		}
			
			break;
	}
    
    controller.delegate = nil;
    
	// Dismiss UIImagePickerController and release it
    [controller dismissViewControllerAnimated:NO completion:NULL];
	[controller.view removeFromSuperview];
    
}

- (void) buttonAction: (CCMenu *) sender
{
    printf("buttonAction\n");
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"knock.caf"];
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
    switch (sender.tag) {
        case 1:
            printf("button 1 pressed\n");
            delegate.currentPage = @"Intro";
            delegate.currentPageDesc = @"STINK BUG INTRODUCTION";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 2:
            printf("button 2 pressed\n");
            delegate.currentPage = @"Photos";
            delegate.currentPageDesc = @"STINK BUG PESTS OF COTTON";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 3:
            printf("button 3 pressed\n");
            delegate.currentPage = @"DamageSymptoms";
            delegate.currentPageDesc = @"STINK BUG DAMAGE SYMPTOMS";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 4:
            printf("button 4 pressed\n");
            delegate.currentPage = @"ScoutingSteps";
            delegate.currentPageDesc = @"STINK BUG SCOUTING STEPS";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 5:
            printf("button 5 pressed\n");
            delegate.currentPage = @"Threshold";
            delegate.currentPageDesc = @"STINK BUG DYNAMIC THRESHOLD";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 6:
            printf("button 6 pressed\n");
            delegate.currentPage = @"Card1";
            delegate.currentPageDesc = @"STINK BUG DECISION AID CARD";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 7:
            printf("button 7 pressed\n");
            delegate.currentPage = @"BollSizer";
            delegate.currentPageDesc = @"STINK BUG BOLL SIZER";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        case 8:
            printf("button 8 pressed\n");
            [delegate setScreenToggle:CALC];
            [delegate replaceTheScene];
            break;
        case 9:
            printf("button 9 pressed\n");
            delegate.currentPage = @"Summary";
            delegate.currentPageDesc = @"STINK BUG SUMMARY";
            [delegate setScreenToggle:CONTENT];
            [delegate replaceTheScene];
            break;
        default:
            break;
    }
}

-(CCSprite*) createSpriteRectangleWithSize:(CGSize)size
{
    CCSprite *sprite = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CCTexture2D *tex = [[CCTexture2D alloc] initWithData:buffer pixelFormat:kCCTexture2DPixelFormat_RGBA8888 pixelsWide:1 pixelsHigh:1 contentSize:size];
    [sprite setTexture:tex];
    [sprite setTextureRect:CGRectMake(0, 0, size.width, size.height)];
    free(buffer);
    return sprite;
}

-(void) onEnterTransitionDidFinish
{
	[super onEnterTransitionDidFinish];
	
    //AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [self setTouchEnabled:YES];
    
}

- (void)dealloc {
	
	NSLog(@"releasing MenuScene elements");
	
    [self unscheduleAllSelectors];
    
    [self removeAllChildrenWithCleanup:YES];
    
	[[CCDirector sharedDirector] purgeCachedData];
	
	[CCSpriteFrameCache purgeSharedSpriteFrameCache];
	[CCTextureCache purgeSharedTextureCache];
	
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
	[[CCTextureCache sharedTextureCache] removeAllTextures];
    
    //[super dealloc];
}

@end
