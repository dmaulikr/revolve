//
//  CircleLayer.m
//  Revolve
//
//  Created by Johan Halin on 16.12.2009.
//  Copyright 2009 Parasol. All rights reserved.
//

#import "Level3Layer.h"
#import <math.h>
#import <stdlib.h>
#import "SimpleAudioEngine.h"
#import "MainMenuScene.h"

@implementation Level3Layer

-(id)init {
	
	self = [super init];
	if(self != nil) {
		[self schedule:@selector(mainLoop:)];
		isTouchEnabled = YES;
/*		
		defaultpng = [[CCSprite spriteWithFile:@"Default.png"] retain];
		defaultpng.anchorPoint = CGPointZero; // HMM!
		//[defaultpng draw];
		[self addChild:defaultpng z:10];
		[defaultpng runAction:[CCFadeOut actionWithDuration:4]];
*/		
		redCircle = [CCSprite spriteWithFile:@"redcircle-3.png"];
		[redCircle setOpacity:0];
		[self addChild:redCircle z:3];
	
		greenCircle = [CCSprite spriteWithFile:@"greencircle-3.png"];
		[greenCircle setOpacity:0];
		[self addChild:greenCircle z:3];
		
		blueCircle = [CCSprite spriteWithFile:@"bluecircle-3.png"];
		[blueCircle setOpacity:0];
		[self addChild:blueCircle z:3];

		orangeCircle = [CCSprite spriteWithFile:@"orangecircleglow-3.png"];
		[orangeCircle setPosition:ccp(160,410)];
		[self addChild:orangeCircle z:5];
		
		orangeCircle2 = [CCSprite spriteWithFile:@"orangecircleglow-3.png"];
		[orangeCircle2 setPosition:ccp(160,260)];
		[self addChild:orangeCircle2 z:5];

		orangeCircle3 = [CCSprite spriteWithFile:@"orangecircleglow-3.png"];
		[orangeCircle3 setPosition:ccp(160,110)];
		[self addChild:orangeCircle3 z:5];
		
		redSquare = [CCSprite spriteWithFile:@"redsquare-3.png"];
		[redSquare setOpacity:0];
		[redSquare setPosition:ccp(160,335)];
		[self addChild:redSquare z:4];
		
		greenSquare = [CCSprite spriteWithFile:@"greensquare-3.png"];
		[greenSquare setOpacity:0];
		[greenSquare setPosition:ccp(160,335)];
		[self addChild:greenSquare z:4];
		
		blueSquare = [CCSprite spriteWithFile:@"bluesquare-3.png"];
		[blueSquare setOpacity:0];
		[blueSquare setPosition:ccp(160,335)];
		[self addChild:blueSquare z:4];
		
		background = [CCSprite spriteWithFile:@"background-3.png"];
		[background setScale:480];
		[background setPosition:ccp(160,240)];
		[self addChild:background z:0];
/*		
		titleScreen = [CCSprite spriteWithFile:@"title.png"];
		[titleScreen setAnchorPoint:ccp(.5f,1)];
		[titleScreen setPosition:ccp(159,308)];
		[self addChild:titleScreen z:6];
*/		
		backgroundLayer = [CCSprite spriteWithFile:@"backgroundlayer-3.png"];
		[backgroundLayer setAnchorPoint:ccp(.5,1)];
		[backgroundLayer setPosition:ccp(160,410)];
		[backgroundLayer setOpacity:0];
		[self addChild:backgroundLayer z:2];
		
		backgroundLayer2 = [CCSprite spriteWithFile:@"backgroundlayer-3.png"];
		[backgroundLayer2 setAnchorPoint:ccp(.5,1)];
		[backgroundLayer2 setPosition:ccp(160,110)];
		[backgroundLayer2 setOpacity:0];
		[self addChild:backgroundLayer2 z:2];
/*		
		gameOverScreen = [CCSprite spriteWithFile:@"tryagain.png"];
		[gameOverScreen setAnchorPoint:ccp(.5f,1)];
		[gameOverScreen setPosition:ccp(159,308)];
		[gameOverScreen setOpacity:0];
		[self addChild:gameOverScreen z:6];
*/
		/* having the cloud glow is way too slow on 2g iphone (*tons* of pixels!)
		 
		brownglow1 = [CCSprite spriteWithFile:@"browncircleglow.png"];
		[brownglow1 setPosition:ccp(40,0)];
		[self addChild:brownglow1 z:1];
		brownglow2 = [CCSprite spriteWithFile:@"browncircleglow.png"];
		[brownglow2 setPosition:ccp(120,0)];
		[self addChild:brownglow2 z:1];
		brownglow3 = [CCSprite spriteWithFile:@"browncircleglow.png"];
		[brownglow3 setPosition:ccp(200,0)];
		[self addChild:brownglow3 z:1];
		brownglow4 = [CCSprite spriteWithFile:@"browncircleglow.png"];
		[brownglow4 setPosition:ccp(280,0)];
		[self addChild:brownglow4 z:1];
*/
		brown1 = [CCSprite spriteWithFile:@"browncircle-3.png"];
		[brown1 setPosition:ccp(40,0)];
		[self addChild:brown1 z:1];
		brown2 = [CCSprite spriteWithFile:@"browncircle-3.png"];
		[brown2 setPosition:ccp(120,0)];
		[self addChild:brown2 z:1];
		brown3 = [CCSprite spriteWithFile:@"browncircle-3.png"];
		[brown3 setPosition:ccp(200,0)];
		[self addChild:brown3 z:1];
		brown4 = [CCSprite spriteWithFile:@"browncircle-3.png"];
		[brown4 setPosition:ccp(280,0)];
		[self addChild:brown4 z:1];

		// Load all sounds and start playing background music at volume 0
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-red.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-green.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-blue.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve-miss.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-1.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-2.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-3.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve3-4.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"start.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"revolve3-base.m4a"];
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"revolve3-base.m4a"];

		[CDAudioManager sharedManager].backgroundMusic.volume = 0.0f;	
		
		// Load highscore (if available) and setup score labels
		userDefaults = [NSUserDefaults standardUserDefaults];
		if(userDefaults) {
			highScore = [userDefaults integerForKey:@"highScore3"];
			totalTaps = [userDefaults integerForKey:@"taps"];
		}
		else {
			highScore = 0;
			totalTaps = 0;
		}

		highScoreString = [NSMutableString stringWithFormat:@"%d", highScore];
		
		highScoreLabel = [CCLabel labelWithString:highScoreString fontName:@"MonkeyLove" fontSize:48];
		[highScoreLabel setAnchorPoint:ccp(.5f,.5f)];
		[highScoreLabel setColor:ccc3(190,212,245)];
		[highScoreLabel setPosition:ccp(160,180)];
		[highScoreLabel setOpacity:0];
		[self addChild:highScoreLabel z:5];
		
		scoreLabel = [CCLabel labelWithString:@"0" fontName:@"MonkeyLove" fontSize:36];
		[scoreLabel setAnchorPoint: ccp(1, 1)];
		[scoreLabel setColor:ccc3(255,255,255)];
		[scoreLabel setPosition:ccp(317,477)];
		[scoreLabel setOpacity:0];
		[self addChild:scoreLabel z:5];		
		
		endScoreLabel = [CCLabel labelWithString:@"0" fontName:@"MonkeyLove" fontSize:48];
		[endScoreLabel setAnchorPoint:ccp(.5f,.5f)];
		[endScoreLabel setColor:ccc3(190,212,245)];
		[endScoreLabel setPosition:ccp(160,280)];
		[endScoreLabel setOpacity:0];
		[self addChild:endScoreLabel z:5];
		
		scoreDescLabel = [CCLabel labelWithString:@"your score" fontName:@"MonkeyLove" fontSize:36];
		[scoreDescLabel setAnchorPoint: ccp(.5f, .5f)];
		[scoreDescLabel setColor:ccc3(190,212,245)];
		[scoreDescLabel setPosition:ccp(160,330)];
		[scoreDescLabel setOpacity:0];
		[self addChild:scoreDescLabel z:5];		
		
		highScoreDescLabel = [CCLabel labelWithString:@"high score" fontName:@"MonkeyLove" fontSize:36];
		[highScoreDescLabel setAnchorPoint: ccp(.5f, .5f)];
		[highScoreDescLabel setColor:ccc3(190,212,245)];
		[highScoreDescLabel setPosition:ccp(160,230)];
		[highScoreDescLabel setOpacity:0];
		[self addChild:highScoreDescLabel z:5];		
		
		
		[CCMenuItemFont setFontName:@"MonkeyLove"];
		[CCMenuItemFont setFontSize:48];
		CCMenuItem *tryAgain = [CCMenuItemFont itemFromString:@"try again" target:self selector:@selector(on1:)];
		CCMenuItem *returnToMenu = [CCMenuItemFont itemFromString:@"go to menu" target:self selector:@selector(on2:)];
		
		menu = [CCMenu menuWithItems:tryAgain, returnToMenu, nil];
		//[menu alignItemsVerticallyWithPadding:0];
		[menu alignItemsVertically];
		
		[menu setColor:ccc3(190,212,245)];
		[menu setPosition:ccp(160,80)];
		[menu setOpacity:0];
		[menu setIsTouchEnabled:NO];
		[self addChild:menu z:5];
		
		logo = [CCSprite spriteWithFile:@"smalllogo3.png"];
		[logo setOpacity:0];
		[logo setPosition:ccp(160,410)];
		[self addChild:logo z:6];
		
		// variables that are only needed for the first time the game is run
		firstGame = YES;
		firstGameCleanup = YES;
		gameOverTimer = 5;		
		startTimer = 0;
		quit = NO;

		[self initGameVariables];
		//[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
		gameStarted = YES;
	}
	return self;
}

-(void)initGameVariables {
	
	NSLog(@"initializing game variables");
	
	speed = 3;
	counter = 0;
	squareCounter = 0;
	squareColor = 0; // 0 = red, 1 = green, 2 = blue
	score = 0;
	[scoreLabel setString:@"0 1x"];
	misses = 1;
	gameOver = NO;
	screenPushed = NO;
	success = NO;
	firstSquareVisible = NO;
	gameStarted = NO;
	circleTimer = 0;
	scoreMultiplier = 1;
	redCounter = M_PI*.75;
	greenCounter = 0;
	blueCounter = M_PI*1.5;
	circleCenter = 380;
	squareUp = YES;
	
	speedRandom = arc4random() % 15;
	redSpeed = 1 + (speedRandom / 100);
	speedRandom = arc4random() % 15;
	greenSpeed = 1 + (speedRandom / 100);
	speedRandom = arc4random() % 15;
	blueSpeed = 1 + (speedRandom / 100);
	
	[greenCircle setPosition:ccp(260,280)];
	[blueCircle setPosition:ccp(160,380)];
	[redCircle setPosition:ccp(60,280)];
	
}

-(void)on1:(id)sender {
	[menu setIsTouchEnabled:NO];
	[self initGameVariables];
	[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
	gameStarted = YES;	
}

-(void)on2:(id)sender {
	[menu setIsTouchEnabled:NO];
	[menu runAction:[CCFadeTo	actionWithDuration:4 opacity:0]];
	[endScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[highScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[scoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[highScoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[logo runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[background runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
	quit = YES;
}

-(void)mainLoop:(ccTime)dt {
	
	timer = timer + dt;
	circleTimer = circleTimer + dt;
	
	// let's CCFade in the music!
	if(startTimer < 4) {
		startTimer = startTimer + dt;
		[CDAudioManager sharedManager].backgroundMusic.volume = startTimer / 4;
	}
	
	// quit
	if(quit == YES) {
		quitTimer = quitTimer + dt;
		cloudHeight = cloudHeight - (quitTimer / 6);
		[CDAudioManager sharedManager].backgroundMusic.volume = 1 - ((quitTimer) / 4);
		if(quitTimer > 4) {
			quitCounter++;
			if(quitCounter == 1) {
				[CDAudioManager sharedManager].backgroundMusic.volume = 0;				
				[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
				[self unschedule:@selector(mainLoop:)]; // gotta stop the timer so that the dealloc method is run
				[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:2 scene:[MainMenuScene node] withColor:ccc3(0,0,0)]];
			}
		}
	}
	
	// code for moving the "cloud"
	[brown1 setPosition:ccp(40,cloudHeight+sin(timer*2)*10)];
	[brown2 setPosition:ccp(120,cloudHeight+sin(1+timer*2)*10)];
	[brown3 setPosition:ccp(200,cloudHeight+sin(2+timer*2)*10)];
	[brown4 setPosition:ccp(280,cloudHeight+sin(3+timer*2)*10)];

	/*
	[brownglow1 setPosition:ccp(40,10+sin(timer*2)*10)];
	[brownglow2 setPosition:ccp(120,10+sin(1+timer*2)*10)];
	[brownglow3 setPosition:ccp(200,10+sin(2+timer*2)*10)];
	[brownglow4 setPosition:ccp(280,10+sin(3+timer*2)*10)];
*/
	
	[backgroundLayer setRotation:180 + squareCounter * 90];
	[backgroundLayer2 setRotation:squareCounter * 90];

	if(gameStarted == YES) {
		squareCounter = squareCounter + dt;		
	}	
	
	// this happens when the game starts
	if(counter < 2 && gameStarted == YES) {
		counter++;
		if(counter == 1) {
			
			[backgroundLayer runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			[backgroundLayer2 runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			[greenCircle runAction:[CCFadeTo actionWithDuration:4 opacity:192]];
			[blueCircle runAction:[CCFadeTo actionWithDuration:4 opacity:192]];
			[redCircle runAction:[CCFadeTo actionWithDuration:4 opacity:192]];
			[scoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			
			if(firstGame == YES) {
				//[titleScreen runAction:[CCFadeOut actionWithDuration:4]];
				firstGame = NO;
			} else {
				//[gameOverScreen runAction:[CCFadeOut actionWithDuration:4]];
				[endScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
				[highScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
				[scoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
				[highScoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
				[menu runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
				[logo runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			}
		}
	}
	
	if(gameOver == YES) {
		if(counter == 2) {
			gameStarted = NO;
			[greenCircle runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[blueCircle runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[redCircle runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[backgroundLayer runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[backgroundLayer2 runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[redSquare runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[greenSquare runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[blueSquare runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[scoreLabel	runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
			[logo runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			
			//[gameOverScreen runAction:[CCFadeIn actionWithDuration:4]];
			scoreString = [NSMutableString stringWithFormat:@"%d", score];
			[endScoreLabel setString:scoreString];
			[endScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			[scoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			[highScoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			
			if(score > highScore) {
				highScore = score;
				[userDefaults setInteger:highScore forKey:@"highScore3"];
				[userDefaults setInteger:totalTaps forKey:@"taps"];
				[userDefaults synchronize];
			}
			highScoreString = [NSMutableString stringWithFormat:@"%d", highScore];
			[highScoreLabel setString:highScoreString];
			[highScoreLabel runAction:[CCFadeIn actionWithDuration:4]];
			
			gameOverTimer = 0;
			counter++;
		} else if(counter == 3) {
			squareCounter = squareCounter + dt;
			gameOverTimer = gameOverTimer + dt;
			if(gameOverTimer > 4) {
				[menu runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
				[menu setIsTouchEnabled:YES];
				counter++;
			}
		}
	} else {
		speed = speed + (.01 * dt);
		if(squareCounter > 2) {
			[self changeColor];
			firstSquareVisible = YES;
			squareCounter = 0;
			[backgroundLayer setOpacity:0];
			[backgroundLayer runAction:[CCFadeTo actionWithDuration:2 opacity:255]];
			[backgroundLayer2 setOpacity:0];
			[backgroundLayer2 runAction:[CCFadeTo actionWithDuration:2 opacity:255]];

			if(scoreMultiplier > 17) {
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-4.m4a"];
			} else if(scoreMultiplier > 11) {
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-3.m4a"];
			} else if(scoreMultiplier > 5) {
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-2.m4a"];
			} else {
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-1.m4a"];				
			}
			
			if(firstGameCleanup == YES) {
				//[self removeChild:titleScreen cleanup:YES];
				//[self removeChild:defaultpng cleanup:YES];
				firstGameCleanup = NO;
			}
		}
	}
	
	if(redCounter > (M_PI*6)) {
		redCounter = 0;
	}
	if(greenCounter > (M_PI*6)) {
		greenCounter = 0;
	}
	if(blueCounter > (M_PI*6)) {
		blueCounter = 0;
	}
	
	redCounter = redCounter + dt * (speed * redSpeed);
	greenCounter = greenCounter + dt * (speed * greenSpeed);
	blueCounter = blueCounter + dt * (speed * blueSpeed);

	redPosition = redCounter + 1.5*M_PI;
	greenPosition = greenCounter + 1.5*M_PI;
	bluePosition = blueCounter + 1.5*M_PI;
/*	
	if(circlePiCounter < (M_PI*2)) {
		[redCircle setPosition:ccp(160 + cos(redPosition) * 100, 380 + sin(redPosition) * 100)];
		[greenCircle setPosition:ccp(160 + cos(greenPosition) * 100, 380 + sin(greenPosition) * 100)];
		[blueCircle setPosition:ccp(160 + cos(bluePosition) * 100, 380 + sin(bluePosition) * 100)];	
	} else {
		[redCircle setPosition:ccp(160 + cos(redPosition) * 100, 180 - sin(redPosition) * 100)];
		[greenCircle setPosition:ccp(160 + cos(greenPosition) * 100, 180 - sin(greenPosition) * 100)];
		[blueCircle setPosition:ccp(160 + cos(bluePosition) * 100, 180 - sin(bluePosition) * 100)];	
	}
 */
	if(redCounter < (M_PI*2)) {
		[redCircle setPosition:ccp(160 + cos(redPosition) * 75, 410 + sin(redPosition) * 75)];		
	} else if(redCounter < (M_PI*3)) {
		[redCircle setPosition:ccp(160 + cos(redPosition) * 75, 260 - sin(redPosition) * 75)];		
	} else if(redCounter < (M_PI*5)) {
		[redCircle setPosition:ccp(160 + cos(redPosition) * 75, 110 + sin(redPosition) * 75)];				
	} else if(redCounter < (M_PI*6)) {
		[redCircle setPosition:ccp(160 + cos(redPosition) * 75, 260 - sin(redPosition) * 75)];		
    }

	if(greenCounter < (M_PI*2)) {
		[greenCircle setPosition:ccp(160 + cos(greenPosition) * 75, 410 + sin(greenPosition) * 75)];		
	} else if(greenCounter < (M_PI*3)) {
		[greenCircle setPosition:ccp(160 + cos(greenPosition) * 75, 260 - sin(greenPosition) * 75)];		
	} else if(greenCounter < (M_PI*5)) {
		[greenCircle setPosition:ccp(160 + cos(greenPosition) * 75, 110 + sin(greenPosition) * 75)];				
	} else if(greenCounter < (M_PI*6)) {
		[greenCircle setPosition:ccp(160 + cos(greenPosition) * 75, 260 - sin(greenPosition) * 75)];		
    }

	if(blueCounter < (M_PI*2)) {
		[blueCircle setPosition:ccp(160 + cos(bluePosition) * 75, 410 + sin(bluePosition) * 75)];		
	} else if(blueCounter < (M_PI*3)) {
		[blueCircle setPosition:ccp(160 + cos(bluePosition) * 75, 260 - sin(bluePosition) * 75)];		
	} else if(blueCounter < (M_PI*5)) {
		[blueCircle setPosition:ccp(160 + cos(bluePosition) * 75, 110 + sin(bluePosition) * 75)];				
	} else if(blueCounter < (M_PI*6)) {
		[blueCircle setPosition:ccp(160 + cos(bluePosition) * 75, 260 - sin(bluePosition) * 75)];		
    }
	
	/*
	redPosition = (speed * redSpeed) * circleTimer; // old = M_PI
	greenPosition = (speed * greenSpeed) * circleTimer + (M_PI * 1.66666); // old = M_PI*1.666
	bluePosition = (speed * blueSpeed) * circleTimer + M_PI / 3; // old = M_PI/3
	*/

	/*
 [greenCircle setPosition:ccp(160 + sin(2*greenPosition) * 100, 280 + sin(greenPosition) * 200)];
	[blueCircle setPosition:ccp(160 + sin(2*bluePosition) * 100, 280 + sin(bluePosition) * 200)];	
*/
 }


-(void)checkCircleRange {
	success = NO;
	//NSLog(@"%f", redCircle.position.y);
	if(screenPushed == NO) {
		if((squareUp == YES && redCircle.position.y < 410 && redCircle.position.y > 260) ||
		   (squareUp == NO && redCircle.position.y < 260 && redCircle.position.y > 110)) {
			if(squareColor == 0) {
				score = score + [self calculateScore:redCircle.position.x];
				success = YES;
				screenPushed = YES;
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-red.m4a"];
				[redCircle setOpacity:255];
				[redCircle runAction:[CCFadeTo actionWithDuration:1 opacity:192]];
				[redSquare runAction:[CCFadeTo actionWithDuration:.5 opacity:0]];
				[greenSquare setOpacity:0];
				[blueSquare setOpacity:0];
			}
		}
		if((squareUp == YES && greenCircle.position.y < 410 && greenCircle.position.y > 260) ||
		   (squareUp == NO && greenCircle.position.y < 260 && greenCircle.position.y > 110)) {
			if(squareColor == 1) {
				score = score + [self calculateScore:greenCircle.position.x];
				success = YES;
				screenPushed = YES;
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-green.m4a"];
				[greenCircle setOpacity:255];
				[greenCircle runAction:[CCFadeTo actionWithDuration:1 opacity:192]];			
				[greenSquare runAction:[CCFadeTo actionWithDuration:.5 opacity:0]];
				[redSquare setOpacity:0];
				[blueSquare setOpacity:0];
			}
		}
		if((squareUp == YES && blueCircle.position.y < 410 && blueCircle.position.y > 260) ||
		   (squareUp == NO && blueCircle.position.y < 260 && blueCircle.position.y > 110)) {
			if(squareColor == 2) {
				score = score + [self calculateScore:blueCircle.position.x];
				success = YES;
				screenPushed = YES;
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve3-blue.m4a"];
				[blueCircle setOpacity:255];
				[blueCircle runAction:[CCFadeTo actionWithDuration:1 opacity:192]];			
				[blueSquare runAction:[CCFadeTo actionWithDuration:.5 opacity:0]];
				[redSquare setOpacity:0];
				[greenSquare setOpacity:0];
			}
		}
	}
	
	if(success == NO) {
		misses = misses - 1;
		if(misses == 0) {
			[missLabel setString:@""];
			gameOver = YES;
		}
		[[SimpleAudioEngine sharedEngine] playEffect:@"revolve-miss.m4a"];
	}

	scoreString = [NSMutableString stringWithFormat:@"%d %dx", score, scoreMultiplier];
	[scoreLabel setString:scoreString];
}


-(void)changeColor {
	
	if(squareUp == NO) {
		newSquareY = 335;
		squareUp = YES;
	} else {
		newSquareY = 185;
		squareUp = NO;
	}
	
	newColor = (arc4random() % 2);
	float squareCCFadeDuration = .1;
	if(squareColor == 0) {
		if(success == NO) {
			[redSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:0]];
		}
		squareColor = squareColor + newColor + 1;
		if(squareColor == 1) {
			[greenSquare setPosition:ccp(160,newSquareY)];
			[greenSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		} else {
			[blueSquare setPosition:ccp(160,newSquareY)];
			[blueSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		}
	} else if(squareColor == 1) {
		if(success == NO) {
			[greenSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:0]];
		}
		if(newColor == 0) {
			squareColor = 0;
			[redSquare setPosition:ccp(160,newSquareY)];
			[redSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		} else {
			squareColor = 2;
			[blueSquare setPosition:ccp(160,newSquareY)];
			[blueSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		}
	} else if(squareColor == 2) {
		if(success == NO) {
			[blueSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:0]];
		}
		squareColor = squareColor - newColor - 1;
		if(squareColor == 0) {
			[redSquare setPosition:ccp(160,newSquareY)];
			[redSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		} else {
			[greenSquare setPosition:ccp(160,newSquareY)];
			[greenSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		}
	}
	success = NO;
	screenPushed = NO;
}


-(int)calculateScore:(float)x {
	
	if(x > 150 && x < 170) {
		scoreMultiplier++;
		return (80 * scoreMultiplier);
	}
	if(x > 140 && x < 180) {
		scoreMultiplier++;
		return (80 * scoreMultiplier);
	}
	if(x > 130 && x < 190) {
		return (40 * scoreMultiplier);
	}
	if(x > 120 && x < 200) {
		scoreMultiplier = 1;
		return 20;
	}
	if(x > 100 && x < 220) {
		scoreMultiplier = 1;
		return 10;
	}
	if(x > 85 && x < 235) {
		scoreMultiplier = 1;
		return 5;
	}
	
	
/*
	if(y < 185) {
		scoreMultiplier++;
		return (80 * scoreMultiplier);
	}
	if(y < 190) {
		return (80 * scoreMultiplier);
	}
	if(y < 200) {
		scoreMultiplier = 1;
		return 40;
	}
	if(y < 210) {
		scoreMultiplier = 1;
		return 20;
	}
	if(y < 220) {
		scoreMultiplier = 1;
		return 10;
	}
	if(y < 230) {
		scoreMultiplier = 1;
		return 5;
	}
 */
	return 0;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {	
	UITouch *touch = [touches anyObject];
	if( touch ) {
		/*
		 if(gameStarted == NO && gameOverTimer > 4) {
			[self initGameVariables];
			[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
			gameStarted = YES;
		} else
		 */
		if(gameOver == NO && firstSquareVisible == YES) {
			[self checkCircleRange];
			totalTaps++;
			return YES;
		}
	}
	return YES;
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	return YES;
}

- (void)dealloc {
	[super dealloc];
}

@end
