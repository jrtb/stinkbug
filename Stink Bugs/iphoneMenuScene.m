//
//  iphoneMenuScene.m
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import "iphoneMenuScene.h"
//#import "MenuScene.h"
//#import "iphoneMenuScene.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

//
// Small scene that plays the background music and makes a transition to the Menu scene
//
@implementation iphoneMenuScene

@synthesize touched;

+(id) scene {
	CCScene *s = [CCScene node];
	id node = [iphoneMenuScene node];
	[s addChild:node];
	return s;
}

-(id) init {
	if( ![super init])
		return nil;
    
    printf("intro scene loading\n");
    
	//printf("intro init\n");
    
	touched = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    //AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    CCSprite *back = [self createSpriteRectangleWithSize:CGSizeMake(size.width,size.height)];
    back.color = ccc3(255,255,255);
    back.position = ccp(size.width*0.5,size.height*.5);
    [self addChild:back z:0];

    CCSprite *mainBack = [CCSprite spriteWithFile:@"menu_bg.pvr.gz"];
    mainBack.anchorPoint = ccp(0.5,1.0);
    mainBack.opacity = 255*.25;
    mainBack.position = ccp(size.width*.5,size.height);
    [self addChild:mainBack z:2];

    CCSprite *brick = [CCSprite spriteWithFile:@"ncsu_brick.pvr.gz"];
    brick.anchorPoint = ccp(0.0,1.0);
    brick.position = ccp(0.0,size.height-0.5);
    [self addChild:brick z:2];

    CCSprite *bottom = [CCSprite spriteWithFile:@"bottom_bar.pvr.gz"];
    bottom.anchorPoint = ccp(0.5,0.5);
    bottom.position = ccp(size.width*.5,bottom.contentSize.height*.5);
    [self addChild:bottom z:2];
    
    labelBottom = [CCLabelBMFont labelWithString:@"STINK BUG DECISION AID" fntFile:@"bottom-menu-14.fnt"];
    labelBottom.anchorPoint = ccp(0.5,0.5);
    labelBottom.position = bottom.position;
    [self addChild:labelBottom z:3];
    
    iphoneAddY = 0;
    
    if (IS_IPHONE5)
        iphoneAddY = 44.0;

    float menuStartY = 240.0+iphoneAddY*2;
    float sepY = 38.5;
    
    /*
    CCMenuItemSprite *itemA = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"main_menu_cellbg.pvr.gz"]
                                                      selectedSprite:[CCSprite spriteWithFile:@"main_menu_cellbg.pvr.gz"]
                                                              target:self
                                                            selector:@selector(aAction:)];
    
    CCMenu  *menuA = [CCMenu menuWithItems:itemA, nil];
    [menuA setPosition:ccp(size.width*.5,menuStartY - sepY*0)];
    [self addChild:menuA z:2];
    
    CCLabelBMFont *labelA = [CCLabelBMFont labelWithString:@"ASPIRE Overview" fntFile:@"main-menu-24.fnt"];
    labelA.anchorPoint = ccp(0.5,0.6);
    labelA.position = menuA.position;
    [self addChild:labelA z:3];
     */

	return self;
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
    
    [self schedule: @selector(start2:) interval:0.0f];
    
    //[self setTouchEnabled:YES];
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	if (!touched) {
        
		touched = YES;
		
		//printf("touched\n");
		
		[self schedule: @selector(start2:) interval:0.0f];
        
	}
}

- (void) start2: (ccTime)sender
{
	[self unschedule: @selector(start2:)];
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [delegate setScreenToggle:MENU];
    
    [delegate replaceTheScene];
    
}

- (void)dealloc {
	
	NSLog(@"releasing iphoneMenuScene elements");
	
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
