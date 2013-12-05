//
//  IntroNode.m
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import "IntroNode.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

//
// Small scene that plays the background music and makes a transition to the Menu scene
//
@implementation IntroNode

@synthesize touched;

+(id) scene {
	CCScene *s = [CCScene node];
	id node = [IntroNode node];
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
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
    if ([delegate isRetina]) {
        back = [CCSprite spriteWithFile:@"Default-Portrait.png"];
    } else {
        back = [CCSprite spriteWithFile:@"Default-Portrait.png"];
    }
    
    back.position = ccp(size.width*.5,size.height*.5);
    [self addChild:back z:0];
    
    //printf("screensize: %f, %f\n",screenSize.width,screenSize.height);
    
	return self;
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
	
	NSLog(@"releasing IntroNode elements");
	
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
