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
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
    
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
    
    labelBottom = [CCLabelBMFont labelWithString:delegate.currentPageDesc fntFile:@"bottom-menu-14.fnt"];
    labelBottom.anchorPoint = ccp(0.5,0.5);
    labelBottom.position = bottom.position;
    [self addChild:labelBottom z:3];
    
    iphoneAddY = 0;
    
    if (IS_IPHONE5)
        iphoneAddY = 44.0;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:delegate.currentPage ofType:@"html"];
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
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];

            delegate.currentPage = @"Threshold";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"GreenSB.html"]) {
            
            labelBottom.string = @"GREEN STINK BUG";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"GreenSB";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"BrownSB.html"]) {
            
            labelBottom.string = @"BROWN STINK BUG";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"BrownSB";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"KudzuSB.html"]) {
            
            labelBottom.string = @"KUDZU BUG";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"KudzuSB";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"MarmoratedSB.html"]) {
            
            labelBottom.string = @"BROWN MARMORATED STINK BUG";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"MarmoratedSB";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"BollWarts.html"]) {
            
            labelBottom.string = @"INTERNAL BOLL WARTS";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"BollWarts";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"LintStain.html"]) {
            
            labelBottom.string = @"STAINED LINT WARTS";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"LintStain";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"HardLock.html"]) {
            
            labelBottom.string = @"BOLLS WITH HARKLOCK";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"HardLock";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"Lesions.html"]) {
            
            labelBottom.string = @"EXTERNAL LESIONS";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"Lesions";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        if ([[request.URL lastPathComponent] isEqualToString:@"DamageSymptoms.html"]) {
            
            labelBottom.string = @"STINK BUG DAMAGE SYMPTOMS";
            
            AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];
            
            delegate.currentPage = @"DamageSymptoms";
            delegate.currentPageDesc = labelBottom.string;
            
        }

        return YES;
    }
    
    return YES;
    
}

- (void) handleSwipeGestureLeft: (id) sender
{
    printf("swipe left\n");

    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];

    NSLog(@"current URL %@",delegate.currentPage);
    
    if ([delegate.currentPage isEqualToString:@"Intro"]) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"short_whoosh.caf"];
        
        [self setTouchEnabled:NO];
        
        [self schedule:@selector(finishSwipe:) interval:0.2];
        
        [UIView animateWithDuration:0.2 animations:^{
            htmlView.frame = CGRectMake(neutral-320, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
        }];

        labelBottom.string = @"STINK BUG PESTS OF COTTON";

        delegate.currentPage = @"Photos";
        delegate.currentPageDesc = labelBottom.string;

    } else if ([delegate.currentPage isEqualToString:@"Photos"] ||
               [delegate.currentPage isEqualToString:@"GreenSB"] ||
               [delegate.currentPage isEqualToString:@"BrownSB"] ||
               [delegate.currentPage isEqualToString:@"KudzuSB"] ||
               [delegate.currentPage isEqualToString:@"MarmoratedSB"]) {

        [[SimpleAudioEngine sharedEngine] playEffect:@"short_whoosh.caf"];
        
        [self setTouchEnabled:NO];
        
        [self schedule:@selector(finishSwipe:) interval:0.2];
        
        [UIView animateWithDuration:0.2 animations:^{
            htmlView.frame = CGRectMake(neutral-320, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
        }];
        
        labelBottom.string = @"STINK BUG DAMAGE SYMPTOMS";
        
        delegate.currentPage = @"DamageSymptoms";
        delegate.currentPageDesc = labelBottom.string;

    }

}

- (void) handleSwipeGestureRight: (id) sender
{
    printf("swipe right\n");
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];

    NSLog(@"current URL %@",delegate.currentPage);
    
    if ([delegate.currentPage isEqualToString:@"Intro"]) {
        
    } else if ([delegate.currentPage isEqualToString:@"Photos"]) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"short_whoosh.caf"];
        
        [self setTouchEnabled:NO];
        
        [self schedule:@selector(finishSwipe:) interval:0.2];
        
        [UIView animateWithDuration:0.2 animations:^{
            htmlView.frame = CGRectMake(neutral+320, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
        }];
        
        labelBottom.string = @"STINK BUG INTRODUCTION";

        delegate.currentPage = @"Intro";
        delegate.currentPageDesc = labelBottom.string;

    } else if ([delegate.currentPage isEqualToString:@"DamageSymptoms"] ||
               [delegate.currentPage isEqualToString:@"GreenSB"] ||
               [delegate.currentPage isEqualToString:@"BrownSB"] ||
               [delegate.currentPage isEqualToString:@"KudzuSB"] ||
               [delegate.currentPage isEqualToString:@"MarmoratedSB"]) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"short_whoosh.caf"];
        
        [self setTouchEnabled:NO];
        
        [self schedule:@selector(finishSwipe:) interval:0.2];
        
        [UIView animateWithDuration:0.2 animations:^{
            htmlView.frame = CGRectMake(neutral+320, htmlView.frame.origin.y, htmlView.frame.size.width, htmlView.frame.size.height);
        }];
        
        labelBottom.string = @"STINK BUG PESTS OF COTTON";
        
        delegate.currentPage = @"Photos";
        delegate.currentPageDesc = labelBottom.string;
        
    }     
}

- (void) finishSwipe: (ccTime) sender
{
    [self unschedule:@selector(finishSwipe:)];
    
    AppController *delegate  = (AppController*) [[UIApplication sharedApplication] delegate];

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:delegate.currentPage ofType:@"html"];
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
