//
//  MainMenuScene.m
//  Revolve
//
//  Created by Johan Halin on 01.02.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import "MainMenuScene.h"
#import "CCMenuItem.h"
#import "CCMenu.h"
#import "GameScene.h"
#import "Level2Scene.h"
#import "Level3Scene.h"
#import "SimpleAudioEngine.h"
#import "CCLabel.h"

@implementation MainMenuScene

-(id)init {
	
	self = [super init];
	if (self != nil) {

		[self schedule:@selector(mainLoop:)];

		menulogo = [CCSprite spriteWithFile:@"title.png"];
		[menulogo setAnchorPoint:CGPointZero];
		//[menulogo setPosition:ccp(160,240)];
		[self addChild:menulogo z:5];
		
		background = [CCSprite spriteWithFile:@"background.png"];
		[background setScale:480]; // having this as a 1x1 image and scaling it saves a *fuckload* of memory .. *bangs head*
		[background setPosition:ccp(160,240)];
		[self addChild:background z:1];
		
		[CCMenuItemFont setFontName:@"MonkeyLove"];
		[CCMenuItemFont setFontSize:48];
		CCMenuItem *level1 = [CCMenuItemFont itemFromString:@"day" target:self selector:@selector(on1:)];
		CCMenuItem *level2 = [CCMenuItemFont itemFromString:@"evening" target:self selector:@selector(on2:)];
		CCMenuItem *level3 = [CCMenuItemFont itemFromString:@"night" target:self selector:@selector(on3:)];
		
		menu = [CCMenu menuWithItems:level1, level2, level3, nil];
		//[menu alignItemsVerticallyWithPadding:0];
		[menu alignItemsVertically];
		
		[menu setColor:ccc3(65,43,10)];
		[menu setPosition:ccp(160,120)];
		[self addChild:menu z:5];
				
		brown1 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown1 setPosition:ccp(40,0)];
		[self addChild:brown1 z:2];
		brown2 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown2 setPosition:ccp(120,0)];
		[self addChild:brown2 z:2];
		brown3 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown3 setPosition:ccp(200,0)];
		[self addChild:brown3 z:2];
		brown4 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown4 setPosition:ccp(280,0)];
		[self addChild:brown4 z:2];
		
		timer = 0;

		[[SimpleAudioEngine sharedEngine] preloadEffect:@"start.m4a"];
		/*
		scoreLabel = [Label labelWithString:@"0" fontName:@"MonkeyLove" fontSize:36];
		[scoreLabel setAnchorPoint: ccp(1, 1)];
		[scoreLabel setColor:ccc3(0,0,0)];
		[scoreLabel setPosition:ccp(317,477)];
		[scoreLabel setOpacity:0];
		[self addChild:scoreLabel z:5];		
		*/
		
		loadingLabel = [CCLabel labelWithString:@"loading" fontName:@"MonkeyLove" fontSize:48];
		[loadingLabel setColor:ccc3(199,184,145)];
		[loadingLabel setPosition:ccp(160,260)];
		[loadingLabel setOpacity:0];
		[self addChild:loadingLabel z:6];
		
		loadLevel = 0;
		loadTimer = 0;
		counter = 0;
		cloudHeight = 0;
		
		[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"revolve-menu.m4a"];
		[CDAudioManager sharedManager].backgroundMusic.volume = 0.0f;	
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"revolve-menu.m4a"];

	}
	return self;
	
}

-(void)on1:(id)sender {
	loadLevel = 1;
}

-(void)on2:(id)sender {
	loadLevel = 2;
}

-(void)on3:(id)sender {
	loadLevel = 3;
}

-(void)mainLoop:(ccTime)dt {

	timer = timer + dt;

	if(timer < 4) {
		[CDAudioManager sharedManager].backgroundMusic.volume = timer / 4;
	}

	//if(loadTimer == 0) {
		[brown1 setPosition:ccp(40, cloudHeight + sin(timer * 2) * 10)];
		[brown2 setPosition:ccp(120, cloudHeight + sin(1 + timer * 2) * 10)];
		[brown3 setPosition:ccp(200, cloudHeight + sin(2 + timer * 2) * 10)];
		[brown4 setPosition:ccp(280, cloudHeight + sin(3 + timer * 2) * 10)];
	//}
	
	if(loadLevel > 0 && loadTimer == 0) {
		[menu setIsTouchEnabled:NO];
		loadTimer = 1;
		[menulogo runAction:[CCFadeOut actionWithDuration:4]];
		[background runAction:[CCFadeOut actionWithDuration:4]];
		[menu runAction:[CCFadeOut actionWithDuration:4]];
		[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
/*
		[brown1	runAction:[MoveTo actionWithDuration:1 position:ccp(40,-50)]];
		[brown2	runAction:[MoveTo actionWithDuration:1 position:ccp(120,-50)]];
		[brown3	runAction:[MoveTo actionWithDuration:1 position:ccp(200,-50)]];
		[brown4	runAction:[MoveTo actionWithDuration:1 position:ccp(280,-50)]];
*/		
		[loadingLabel runAction:[CCFadeIn actionWithDuration:4]];
	}
	
	if(loadTimer > 0) {
		[CDAudioManager sharedManager].backgroundMusic.volume = 1 - ((loadTimer - 1) / 4);
		cloudHeight = cloudHeight - (loadTimer / 4);
		loadTimer = loadTimer + dt;
	}
	
	if(loadTimer > 5) {
		if(counter == 0) {
			counter++;
			[CDAudioManager sharedManager].backgroundMusic.volume = 0;
			[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
			[self unschedule:@selector(mainLoop:)]; // gotta stop the timer so that the dealloc method is run

			if(loadLevel == 1) {
				[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:2 scene:[GameScene node] withColor:ccc3(0,0,0)]];
			}
			if(loadLevel == 2) {
				[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:2 scene:[Level2Scene node] withColor:ccc3(0,0,0)]];
			}
			if(loadLevel == 3) {
				[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:2 scene:[Level3Scene node] withColor:ccc3(0,0,0)]];
			}
		}
	}	
}

- (void)dealloc {
	[super dealloc];
}

@end
