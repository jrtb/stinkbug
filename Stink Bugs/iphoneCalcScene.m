//
//  iphoneCalcScene.m
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import "iphoneCalcScene.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

//
// Small scene that plays the background music and makes a transition to the Menu scene
//
@implementation iphoneCalcScene

@synthesize touched;

+(id) scene {
	CCScene *s = [CCScene node];
	id node = [iphoneCalcScene node];
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
    
    //AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
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
    
    labelBottom = [CCLabelBMFont labelWithString:@"STINK BUG THRESHOLD CALCULATOR" fntFile:@"bottom-menu-14.fnt"];
    labelBottom.anchorPoint = ccp(0.5,0.5);
    labelBottom.position = bottom.position;
    [self addChild:labelBottom z:3];
    
    iphoneAddY = 0;
    
    if (IS_IPHONE5)
        iphoneAddY = 44.0;

    CCSprite *a1Small = [CCSprite spriteWithFile:@"back_button.pvr.gz"];
    a1Small.color = ccGRAY;
    
    CCMenuItemSprite *itemA1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"back_button.pvr.gz"]
                                                       selectedSprite:a1Small
                                                               target:self
                                                             selector:@selector(closeAction:)];
    
    CCMenu  *menuA1 = [CCMenu menuWithItems:itemA1, nil];
    [menuA1 setPosition:ccp(size.width-40,size.height-20)];
    [self addChild:menuA1 z:70];

	return self;
}

- (void) closeAction: (id)sender
{
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
    //if (![appDelegate muted]) {
    [[SimpleAudioEngine sharedEngine] playEffect:@"knock.caf"];
    //}
    
    [delegate setScreenToggle:MENU];
    
    [delegate replaceTheScene];
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
    
    //[self setTouchEnabled:YES];
    
}


- (void)dealloc {
	
	NSLog(@"releasing iphoneCalcScene elements");
	
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
