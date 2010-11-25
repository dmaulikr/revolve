//
//  CircleLayer.m
//  Revolve
//
//  Created by Johan Halin on 16.12.2009.
//  Copyright 2009 Parasol. All rights reserved.
//

#import "CircleLayer.h"
#import <math.h>
#import <stdlib.h>
#import "SimpleAudioEngine.h"
#import "MainMenuScene.h"

@implementation CircleLayer

-(id)init {
	
	self = [super init];
	if(self != nil) {
		[self schedule:@selector(mainLoop:)];
		isTouchEnabled = YES;
	/*	
		defaultpng = [[CCSprite CCSpriteWithFile:@"Default.png"] retain];
		defaultpng.anchorPoint = CGPointZero; // HMM!
		//[defaultpng draw];
		[self addChild:defaultpng z:10];
		[defaultpng runAction:[CCFadeOut actionWithDuration:4]];
	*/	

		greenCircle = [CCSprite spriteWithFile:@"greencircle.png"];
		[greenCircle setOpacity:0];
		[self addChild:greenCircle z:3];
		
		blueCircle = [CCSprite spriteWithFile:@"bluecircle.png"];
		[blueCircle setOpacity:0];
		[self addChild:blueCircle z:3];

		orangeCircle = [CCSprite spriteWithFile:@"orangecircleglow.png"];
		[orangeCircle setPosition:ccp(160,280)];
		[self addChild:orangeCircle z:5];
		
		redCircle = [CCSprite spriteWithFile:@"redcircle.png"];
		[redCircle setOpacity:0];
		[self addChild:redCircle z:3];
		
		redSquare = [CCSprite spriteWithFile:@"redsquare.png"];
		[redSquare setOpacity:0];
		[redSquare setPosition:ccp(160,140)];
		[self addChild:redSquare z:4];
		
		greenSquare = [CCSprite spriteWithFile:@"greensquare.png"];
		[greenSquare setOpacity:0];
		[greenSquare setPosition:ccp(160,140)];
		[self addChild:greenSquare z:4];
		
		blueSquare = [CCSprite spriteWithFile:@"bluesquare.png"];
		[blueSquare setOpacity:0];
		[blueSquare setPosition:ccp(160,140)];
		[self addChild:blueSquare z:4];
		
		background = [CCSprite spriteWithFile:@"background.png"];
		[background setScale:480];
		[background setPosition:ccp(160,240)];
		[self addChild:background z:0];
		/*
		titleScreen = [CCSprite CCSpriteWithFile:@"title.png"];
		[titleScreen setAnchorPoint:ccp(.5f,1)];
		[titleScreen setPosition:ccp(159,308)];
		[self addChild:titleScreen z:6];
		*/
		backgroundLayer = [CCSprite spriteWithFile:@"backgroundsquare.png"];
		[backgroundLayer setAnchorPoint:ccp(.5,1)];
		[backgroundLayer setPosition:ccp(160,280)];
		[backgroundLayer setOpacity:0];
		[self addChild:backgroundLayer z:2];
	/*	
		gameOverScreen = [CCSprite CCSpriteWithFile:@"tryagain.png"];
		[gameOverScreen setAnchorPoint:ccp(.5f,1)];
		[gameOverScreen setPosition:ccp(159,308)];
		[gameOverScreen setOpacity:0];
		[self addChild:gameOverScreen z:6];
*/
		/* having the cloud glow is way too slow on 2g iphone (*tons* of pixels!)
		 
		brownglow1 = [CCSprite CCSpriteWithFile:@"browncircleglow.png"];
		[brownglow1 setPosition:ccp(40,0)];
		[self addChild:brownglow1 z:1];
		brownglow2 = [CCSprite CCSpriteWithFile:@"browncircleglow.png"];
		[brownglow2 setPosition:ccp(120,0)];
		[self addChild:brownglow2 z:1];
		brownglow3 = [CCSprite CCSpriteWithFile:@"browncircleglow.png"];
		[brownglow3 setPosition:ccp(200,0)];
		[self addChild:brownglow3 z:1];
		brownglow4 = [CCSprite CCSpriteWithFile:@"browncircleglow.png"];
		[brownglow4 setPosition:ccp(280,0)];
		[self addChild:brownglow4 z:1];
*/
		brown1 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown1 setPosition:ccp(40,0)];
		[self addChild:brown1 z:1];
		brown2 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown2 setPosition:ccp(120,0)];
		[self addChild:brown2 z:1];
		brown3 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown3 setPosition:ccp(200,0)];
		[self addChild:brown3 z:1];
		brown4 = [CCSprite spriteWithFile:@"browncircle.png"];
		[brown4 setPosition:ccp(280,0)];
		[self addChild:brown4 z:1];

		// Load all sounds and start playing background music at volume 0
		[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"revolve-base.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve-red.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve-green.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve-blue.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve-miss.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"revolve-colorchangeCCFade.m4a"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"start.m4a"];
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"revolve-base.m4a"];

		[CDAudioManager sharedManager].backgroundMusic.volume = 0.0f;	
		
		// Load highscore (if available) and setup score labels
		userDefaults = [NSUserDefaults standardUserDefaults];
		if(userDefaults) {
			highScore = [userDefaults integerForKey:@"highScore"];
			totalTaps = [userDefaults integerForKey:@"taps"];
		}
		else {
			highScore = 0;
			totalTaps = 0;
		}

		highScoreString = [NSMutableString stringWithFormat:@"%d", highScore];
		
		highScoreLabel = [CCLabel labelWithString:highScoreString fontName:@"MonkeyLove" fontSize:48];
		[highScoreLabel setAnchorPoint:ccp(.5f,.5f)];
		[highScoreLabel setColor:ccc3(65,43,10)];
		[highScoreLabel setPosition:ccp(160,180)];
		[highScoreLabel setOpacity:0];
		[self addChild:highScoreLabel z:5];

		scoreLabel = [CCLabel labelWithString:@"0" fontName:@"MonkeyLove" fontSize:36];
		[scoreLabel setAnchorPoint: ccp(1, 1)];
		[scoreLabel setColor:ccc3(0,0,0)];
		[scoreLabel setPosition:ccp(317,477)];
		[scoreLabel setOpacity:0];
		[self addChild:scoreLabel z:5];		
		
		endScoreLabel = [CCLabel labelWithString:@"0" fontName:@"MonkeyLove" fontSize:48];
		[endScoreLabel setAnchorPoint:ccp(.5f,.5f)];
		[endScoreLabel setColor:ccc3(65,43,10)];
		[endScoreLabel setPosition:ccp(160,280)];
		[endScoreLabel setOpacity:0];
		[self addChild:endScoreLabel z:5];
				
		scoreDescLabel = [CCLabel labelWithString:@"your score" fontName:@"MonkeyLove" fontSize:36];
		[scoreDescLabel setAnchorPoint: ccp(.5f, .5f)];
		[scoreDescLabel setColor:ccc3(65,43,10)];
		[scoreDescLabel setPosition:ccp(160,330)];
		[scoreDescLabel setOpacity:0];
		[self addChild:scoreDescLabel z:5];		

		highScoreDescLabel = [CCLabel labelWithString:@"high score" fontName:@"MonkeyLove" fontSize:36];
		[highScoreDescLabel setAnchorPoint: ccp(.5f, .5f)];
		[highScoreDescLabel setColor:ccc3(65,43,10)];
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
		
		[menu setColor:ccc3(65,43,10)];
		[menu setPosition:ccp(160,80)];
		[menu setOpacity:0];
		[menu setIsTouchEnabled:NO];
		[self addChild:menu z:5];
		
		logo = [CCSprite spriteWithFile:@"smalllogo.png"];
		[logo setOpacity:0];
		[logo setPosition:ccp(160,410)];
		[self addChild:logo z:3];

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

-(void)on1:(id)sender {
	[menu setIsTouchEnabled:NO];
	[self initGameVariables];
	[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
	gameStarted = YES;	
}

-(void)on2:(id)sender {
	[menu setIsTouchEnabled:NO];
	[menu runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[endScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[highScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[scoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[highScoreDescLabel runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[logo runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[background runAction:[CCFadeTo actionWithDuration:4 opacity:0]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"start.m4a"];
	quit = YES;
}

-(void)initGameVariables {
	
	NSLog(@"initializing game variables");
	
	speed = .7;
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
	quitCounter = 0;
	quitTimer = 0;
	cloudHeight = 10;
	
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

-(void)mainLoop:(ccTime)dt {
	
	timer = timer + dt;
	circleTimer = circleTimer + dt;
	
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
	
	// let's CCFade in the music!
	if(startTimer < 4) {
		startTimer = startTimer + dt;
		[CDAudioManager sharedManager].backgroundMusic.volume = startTimer / 4;		
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
	
	[backgroundLayer setRotation:180 + squareCounter * 45];

	if(gameStarted == YES) {
		squareCounter = squareCounter + dt;		
	}	
	
	// this happens when the game starts
	if(counter < 2 && gameStarted == YES) {
		counter++;
		if(counter == 1) {

			[backgroundLayer runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
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
				[menu setIsTouchEnabled:NO];
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
				[userDefaults setInteger:highScore forKey:@"highScore"];
				[userDefaults setInteger:totalTaps forKey:@"taps"];
				[userDefaults synchronize];
			}
			highScoreString = [NSMutableString stringWithFormat:@"%d", highScore];
			[highScoreLabel setString:highScoreString];
			[highScoreLabel runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
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
		speed = speed + (.012 * dt);
		if(squareCounter > 4) {
			[self changeColor];
			firstSquareVisible = YES;
			squareCounter = 0;
			[backgroundLayer setOpacity:0];
			[backgroundLayer runAction:[CCFadeTo actionWithDuration:4 opacity:255]];
			[[SimpleAudioEngine sharedEngine] playEffect:@"revolve-colorchangeCCFade.m4a"];
			if(firstGameCleanup == YES) {
				//[self removeChild:titleScreen cleanup:YES];
				//[self removeChild:defaultpng cleanup:YES];
				firstGameCleanup = NO;
			}
		}
	}
	
	redPosition = (speed * redSpeed) * circleTimer + M_PI; // old = M_PI
	greenPosition = (speed * greenSpeed) * circleTimer + (M_PI * 1.66666); // old = M_PI*1.666
	bluePosition = (speed * blueSpeed) * circleTimer + M_PI / 3; // old = M_PI/3
	
	[redCircle setPosition:ccp(160 + cos(redPosition) * 100, 280 + sin(redPosition) * 100)];
	[greenCircle setPosition:ccp(160 + cos(greenPosition) * 100, 280 + sin(greenPosition) * 100)];
	[blueCircle setPosition:ccp(160 + cos(bluePosition) * 100, 280 + sin(bluePosition) * 100)];
	
}


-(void)checkCircleRange {
	success = NO;
	//NSLog(@"%f", redCircle.position.y);
	if(screenPushed == NO) {
		if(redCircle.position.y < 265) {
			if(squareColor == 0) {
				score = score + [self calculateScore:redCircle.position.x];
				success = YES;
				screenPushed = YES;
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve-red.m4a"];
				[redCircle setOpacity:255];
				[redCircle runAction:[CCFadeTo actionWithDuration:1 opacity:192]];
				[redSquare runAction:[CCFadeTo actionWithDuration:.5 opacity:0]];
				[greenSquare setOpacity:0];
				[blueSquare setOpacity:0];
			}
		}
		if(greenCircle.position.y < 265) {
			if(squareColor == 1) {
				score = score + [self calculateScore:greenCircle.position.x];
				success = YES;
				screenPushed = YES;
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve-green.m4a"];
				[greenCircle setOpacity:255];
				[greenCircle runAction:[CCFadeTo actionWithDuration:1 opacity:192]];			
				[greenSquare runAction:[CCFadeTo actionWithDuration:.5 opacity:0]];
				[redSquare setOpacity:0];
				[blueSquare setOpacity:0];
			}
		}
		if(blueCircle.position.y < 265) {
			if(squareColor == 2) {
				score = score + [self calculateScore:blueCircle.position.x];
				success = YES;
				screenPushed = YES;
				[[SimpleAudioEngine sharedEngine] playEffect:@"revolve-blue.m4a"];
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
	
	newColor = (arc4random() % 2);
	float squareCCFadeDuration = .1;
	if(squareColor == 0) {
		if(success == NO) {
			[redSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:0]];
		}
		squareColor = squareColor + newColor + 1;
		if(squareColor == 1) {
			[greenSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		} else {
			[blueSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		}
	} else if(squareColor == 1) {
		if(success == NO) {
			[greenSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:0]];
		}
		if(newColor == 0) {
			squareColor = 0;
			[redSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		} else {
			squareColor = 2;
			[blueSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		}
	} else if(squareColor == 2) {
		if(success == NO) {
			[blueSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:0]];
		}
		squareColor = squareColor - newColor - 1;
		if(squareColor == 0) {
			[redSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		} else {
			[greenSquare runAction:[CCFadeTo actionWithDuration:squareCCFadeDuration opacity:128]];
		}
	}
	success = NO;
	screenPushed = NO;
}


-(int)calculateScore:(float)x {

	if(x > 145 && x < 175) {
		scoreMultiplier++;
		return (80 * scoreMultiplier);
	}
	if(x > 140 && x < 180) {
		return (80 * scoreMultiplier);
	}
	if(x > 120 && x < 200) {
		return (40 * scoreMultiplier);
	}
	if(x > 100 && x < 220) {
		scoreMultiplier = 1;
		return 20;
	}
	if(x > 80 && x < 240) {
		scoreMultiplier = 1;
		return 10;
	}
	if(x > 60 && x < 260) {
		scoreMultiplier = 1;
		return 5;
	}
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
