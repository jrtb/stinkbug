//
//  iphoneContentScene.m
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import "iphoneContentScene.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

@implementation iphoneContentScene

@synthesize touched;

+(id) scene {
	CCScene *s = [CCScene node];
	id node = [iphoneContentScene node];
	[s addChild:node];
	return s;
}

-(id) init {
	if( ![super init])
		return nil;
    
    printf("content scene loading\n");
    
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
    
    labelBottom = [CCLabelBMFont labelWithString:@"STINK BUG INTRODUCTION" fntFile:@"bottom-menu-14.fnt"];
    labelBottom.anchorPoint = ccp(0.5,0.5);
    labelBottom.position = bottom.position;
    [self addChild:labelBottom z:3];
    
    iphoneAddY = 0;
    
    if (IS_IPHONE5)
        iphoneAddY = 44.0;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
	htmlView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 52.0, size.width, size.height-52.0-32.0)];
	htmlView.userInteractionEnabled = YES;
    htmlView.backgroundColor = [UIColor clearColor];
    htmlView.opaque = NO;
    htmlView.delegate = self;
	//questionView.text = question;
	//questionView.editable = NO;
	//questionView.font = [UIFont fontWithName:@"Arial" size:20.0f];
    [htmlView loadHTMLString:htmlString baseURL:baseURL];
    
    currentPage = @"Intro";
    
	viewWrapper = [CCUIViewWrapper wrapperForUIView:htmlView];
	[self addChild:viewWrapper];
    
    neutral = htmlView.frame.origin.x;

    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(handleSwipeGestureLeft:)];
    [htmlView addGestureRecognizer:swipeGestureLeft];
    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleSwipeGestureRight:)];
    swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [htmlView addGestureRecognizer:swipeGestureRight];
    
    [swipeGestureRight setDelegate:self];

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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked){
    
        [[SimpleAudioEngine sharedEngine] playEffect:@"knock.caf"];

        //NSLog(@"loading URL %@",[request.URL lastPathComponent]);
        
        if ([[request.URL lastPathComponent] isEqualToString:@"Threshold.html"]) {
            
            labelBottom.string = @"STINK BUG DYNAMIC THRESHOLD";
            
            currentPage = @"Threshold";
            
        }
        
        return YES;
    }
    
    return YES;
    
}

- (void) handleSwipeGestureLeft: (id) sender
{
    printf("swipe left\n");
    
    NSLog(@"current URL %@",currentPage);

    if ([currentPage isEqualToString:@"Intro"]) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"short_whoosh.caf"];
        
        [self setTouchEnabled:NO];
        
        [self schedule:@selector(finishSwipe:) interval:0.2];
        
        [UIView animateWithDuration:0.2 animations:^{
            htmlView.frame = CGRectMake(neutral-320, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
        }];
    
        labelBottom.string = @"STINK BUG DYNAMIC THRESHOLD";

        currentPage = @"Threshold";
        
    } else if ([currentPage isEqualToString:@"Threshold"]) {
        
    }

}

- (void) handleSwipeGestureRight: (id) sender
{
    printf("swipe right\n");
    
    NSLog(@"current URL %@",currentPage);
    
    if ([currentPage isEqualToString:@"Intro"]) {
        
    } else if ([currentPage isEqualToString:@"Threshold"]) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"short_whoosh.caf"];
        
        [self setTouchEnabled:NO];
        
        [self schedule:@selector(finishSwipe:) interval:0.2];
        
        [UIView animateWithDuration:0.2 animations:^{
            htmlView.frame = CGRectMake(neutral+320, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
        }];
        
        labelBottom.string = @"STINK BUG INTRODUCTION";

        currentPage = @"Intro";
        
    }
    
}

- (void) finishSwipe: (ccTime) sender
{
    [self unschedule:@selector(finishSwipe:)];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:currentPage ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [htmlView loadHTMLString:htmlString baseURL:baseURL];

    [self schedule:@selector(finishSwipe2:) interval:0.05];

}

- (void) finishSwipe2: (ccTime) sender
{
    [self unschedule:@selector(finishSwipe2:)];

    htmlView.frame = CGRectMake(neutral, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
    
    [self setTouchEnabled:YES];

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
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

- (void) buttonAction: (CCMenu *) sender
{
    printf("buttonAction\n");
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"knock.caf"];
    
    switch (sender.tag) {
        case 1:
            printf("button 1 pressed\n");
            break;
        case 2:
            printf("button 2 pressed\n");
            break;
        case 3:
            printf("button 3 pressed\n");
            break;
        case 4:
            printf("button 4 pressed\n");
            break;
        case 5:
            printf("button 5 pressed\n");
            break;
        case 6:
            printf("button 6 pressed\n");
            break;
        case 7:
            printf("button 7 pressed\n");
            break;
        case 8:
            printf("button 8 pressed\n");
            break;
        case 9:
            printf("button 9 pressed\n");
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
	
	NSLog(@"releasing iphoneContentScene elements");
	
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
