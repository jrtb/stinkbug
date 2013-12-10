//
//  iphoneCalcScene.m
//  Stink Bugs iOS
//
//  Created by James RT Bossert on 11/13/2013.
//

#import "iphoneCalcScene.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

#import "CCUIViewWrapper.h"

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
    
    /*
    CCSprite *brick = [CCSprite spriteWithFile:@"ncsu_brick.pvr.gz"];
    brick.anchorPoint = ccp(0.0,1.0);
    brick.position = ccp(0.0,size.height-0.5);
    [self addChild:brick z:2];
    */
    
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
    
    float startingX = 133.0;
    
    float startingY = 370.0-88+iphoneAddY*2;

    CCLabelTTF *someLabel_s = [CCLabelTTF labelWithString:@"Threshold Calculator" fontName:@"Helvetica Neue" fontSize:28 dimensions:CGSizeMake(300.0, 60.0) hAlignment:kCCTextAlignmentCenter];
    someLabel_s.position = ccp(160, startingY+120.0);
    someLabel_s.color = ccc3FromUInt(0x000000);
    someLabel_s.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_s z:4];

    CCLabelTTF *someLabel_e = [CCLabelTTF labelWithString:@"Input the following to determine your internal damage to 1-inch diameter bolls meets the treatment threshold:" fontName:@"Arial-ItalicMT" fontSize:16 dimensions:CGSizeMake(300.0, 120.0) hAlignment:kCCTextAlignmentCenter];
    someLabel_e.position = ccp(160, startingY-200.0);
    someLabel_e.color = ccc3FromUInt(0x000000);
    someLabel_e.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_e z:4];

    task_01Field = [[UITextField alloc] initWithFrame:CGRectMake(startingX+80.0, startingY-260+88-iphoneAddY*2, 60, 40)];
    [task_01Field setBackgroundColor:[UIColor whiteColor]];
    task_01Field.borderStyle = UITextBorderStyleRoundedRect;
    [task_01Field setFont:[UIFont systemFontOfSize:16]];
    [task_01Field setReturnKeyType:UIReturnKeyDone];
    [task_01Field setAutocorrectionType:UITextAutocorrectionTypeNo];
    task_01Field.text = @"1";
    [task_01Field setDelegate:self];
    [task_01Field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    CCUIViewWrapper *viewWrapper = [CCUIViewWrapper wrapperForUIView:task_01Field];
	[self addChild:viewWrapper z:10];

    task_02Field = [[UITextField alloc] initWithFrame:CGRectMake(startingX+80.0, startingY-210+88-iphoneAddY*2, 60, 40)];
    [task_02Field setBackgroundColor:[UIColor whiteColor]];
    task_02Field.borderStyle = UITextBorderStyleRoundedRect;
    [task_02Field setFont:[UIFont systemFontOfSize:16]];
    [task_02Field setReturnKeyType:UIReturnKeyDone];
    [task_02Field setAutocorrectionType:UITextAutocorrectionTypeNo];
    task_02Field.text = @"1";
    [task_02Field setDelegate:self];
    [task_02Field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    CCUIViewWrapper *viewWrapper_02 = [CCUIViewWrapper wrapperForUIView:task_02Field];
	[self addChild:viewWrapper_02 z:10];

    task_03Field = [[UITextField alloc] initWithFrame:CGRectMake(startingX+80.0, startingY-160+88-iphoneAddY*2, 60, 40)];
    [task_03Field setBackgroundColor:[UIColor whiteColor]];
    task_03Field.borderStyle = UITextBorderStyleRoundedRect;
    [task_03Field setFont:[UIFont systemFontOfSize:16]];
    [task_03Field setReturnKeyType:UIReturnKeyDone];
    [task_03Field setAutocorrectionType:UITextAutocorrectionTypeNo];
    task_03Field.text = @"1";
    [task_03Field setDelegate:self];
    [task_03Field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    CCUIViewWrapper *viewWrapper_03 = [CCUIViewWrapper wrapperForUIView:task_03Field];
	[self addChild:viewWrapper_03 z:10];

    CCLabelTTF *someLabel_01 = [CCLabelTTF labelWithString:@"Week of bloom" fontName:@"Helvetica" fontSize:16 dimensions:CGSizeMake(140.0, 40.0) hAlignment:kCCTextAlignmentLeft];
    someLabel_01.position = ccp(startingX, startingY+70);
    someLabel_01.color = ccc3FromUInt(0x000000);
    someLabel_01.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_01 z:4];

    CCLabelTTF *someLabel_02 = [CCLabelTTF labelWithString:@"Number of bolls sampled" fontName:@"Helvetica" fontSize:16 dimensions:CGSizeMake(140.0, 80.0) hAlignment:kCCTextAlignmentLeft];
    someLabel_02.position = ccp(startingX, startingY+70-50);
    someLabel_02.color = ccc3FromUInt(0x000000);
    someLabel_02.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_02 z:4];

    CCLabelTTF *someLabel_03 = [CCLabelTTF labelWithString:@"Damaged bolls" fontName:@"Helvetica" fontSize:16 dimensions:CGSizeMake(140.0, 40.0) hAlignment:kCCTextAlignmentLeft];
    someLabel_03.position = ccp(startingX, startingY+70-100);
    someLabel_03.color = ccc3FromUInt(0x000000);
    someLabel_03.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_03 z:4];

    CCLabelTTF *someLabel_04 = [CCLabelTTF labelWithString:@"Treatment threshold" fontName:@"Helvetica" fontSize:16 dimensions:CGSizeMake(140.0, 80.0) hAlignment:kCCTextAlignmentLeft];
    someLabel_04.position = ccp(startingX, startingY+70-150);
    someLabel_04.color = ccc3FromUInt(0x000000);
    someLabel_04.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_04 z:4];

    CCLabelTTF *someLabel_05 = [CCLabelTTF labelWithString:@"Your threshold" fontName:@"Helvetica" fontSize:16 dimensions:CGSizeMake(140.0, 80.0) hAlignment:kCCTextAlignmentLeft];
    someLabel_05.position = ccp(startingX, startingY+70-200);
    someLabel_05.color = ccc3FromUInt(0x000000);
    someLabel_05.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:someLabel_05 z:4];

    treatment_threshold_calculated = [CCLabelTTF labelWithString:@"50%" fontName:@"Helvetica" fontSize:20 dimensions:CGSizeMake(140.0, 80.0) hAlignment:kCCTextAlignmentLeft];
    treatment_threshold_calculated.position = ccp(startingX+154.0, startingY+70-150);
    treatment_threshold_calculated.color = ccc3FromUInt(0x000000);
    treatment_threshold_calculated.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:treatment_threshold_calculated z:4];

    your_threshold_calculated = [CCLabelTTF labelWithString:@"100%" fontName:@"Helvetica" fontSize:20 dimensions:CGSizeMake(140.0, 80.0) hAlignment:kCCTextAlignmentLeft];
    your_threshold_calculated.position = ccp(startingX+154.0, startingY+70-200);
    your_threshold_calculated.color = ccc3FromUInt(0x000000);
    your_threshold_calculated.verticalAlignment = kCCVerticalTextAlignmentCenter;
    [self addChild:your_threshold_calculated z:4];

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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
		return NO;
        //} else if ([[textView text] length] + [text length] - range.length > 140) {
        //    return NO;
	} else {
		return YES;
	}
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    printf("textFieldDidEndEditing\n");
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    printf("textFieldShouldReturn\n");
    
    if (task_01Field == textField) {
        
        // switch treatment_threshold_calculated value
        
        task_01Field.text = [task_01Field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([task_01Field.text isEqualToString:@"1"])
            treatment_threshold_calculated.string = @"50%";
        else if ([task_01Field.text isEqualToString:@"2"])
            treatment_threshold_calculated.string = @"30%";
        else if ([task_01Field.text isEqualToString:@"3"])
            treatment_threshold_calculated.string = @"10%";
        else if ([task_01Field.text isEqualToString:@"4"])
            treatment_threshold_calculated.string = @"10%";
        else if ([task_01Field.text isEqualToString:@"5"])
            treatment_threshold_calculated.string = @"10%";
        else if ([task_01Field.text isEqualToString:@"6"])
            treatment_threshold_calculated.string = @"20%";
        else if ([task_01Field.text isEqualToString:@"7"])
            treatment_threshold_calculated.string = @"30%";
        else if ([task_01Field.text isEqualToString:@"8"])
            treatment_threshold_calculated.string = @"50%";
        else
            treatment_threshold_calculated.string = @"--";
        
        [task_01Field resignFirstResponder];
        [task_02Field becomeFirstResponder];
    }
    
    if (task_02Field == textField) {
        
        task_02Field.text = [task_02Field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        float c = (([task_03Field.text floatValue] / [task_02Field.text floatValue]) * 100.0);
        
        if (c > 100.0) c = 100.0;
        
        printf("%f\n",c);
        
        your_threshold_calculated.string = [[NSString stringWithFormat:@"%.0f",c] stringByAppendingString:@"%"];
        
        [task_02Field resignFirstResponder];
        [task_03Field becomeFirstResponder];
    }
    
    if (task_03Field == textField) {
        
        task_03Field.text = [task_03Field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        float c = (([task_03Field.text floatValue] / [task_02Field.text floatValue]) * 100.0);
        
        if (c > 100.0) c = 100.0;

        printf("%f\n",c);
        
        your_threshold_calculated.string = [[NSString stringWithFormat:@"%.0f",c] stringByAppendingString:@"%"];
        
        [task_03Field resignFirstResponder];
    }
    
    return YES;
}

static inline ccColor3B
ccc3FromUInt(const uint bytes)
{
	GLubyte r	= bytes >> 16 & 0xFF;
	GLubyte g	= bytes >> 8 & 0xFF;
	GLubyte b	= bytes & 0xFF;
    
	return ccc3(r, g, b);
}

static inline uint
uintFromCCC3(const ccColor3B ccColor)
{
	return (ccColor.r << 16 | ccColor.g << 8 | ccColor.b);
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
