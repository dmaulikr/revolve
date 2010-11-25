//
//  CircleLayer.h
//  Revolve
//
//  Created by Johan Halin on 16.12.2009.
//  Copyright 2009 Parasol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayer.h"
#import "CCSprite.h"

@interface CircleLayer : CCLayer <CCTargetedTouchDelegate> {
	CCSprite *greenCircle;
	CCSprite *blueCircle;
	CCSprite *orangeCircle;
	CCSprite *redCircle;
	CCSprite *titleScreen;
	CCSprite *gameOverScreen;
	
	CCSprite *greenSquare;
	CCSprite *blueSquare;
	CCSprite *redSquare;
	
	CCSprite *brown1;
	CCSprite *brown2;
	CCSprite *brown3;
	CCSprite *brown4;
	CCSprite *brownglow1;
	CCSprite *brownglow2;
	CCSprite *brownglow3;
	CCSprite *brownglow4;
	
	CCSprite *backgroundLayer;
	
	CCSprite *defaultpng;
		
	NSMutableString *scoreString;
	NSMutableString *highScoreString;
	
	float timer;
	float speed;
	float squareCounter; // also used for timing the background movement
	float redPosition;
	float greenPosition;
	float bluePosition;
	float redSpeed;
	float greenSpeed;
	float blueSpeed;
	float speedRandom;
	float gameOverTimer;
	float circleTimer;
	float startTimer;
	
	int counter;
	int squareColor;
	int newColor;
	int score;
	int misses;
	int highScore;
	int scoreMultiplier;
	int totalTaps;
	
	bool gameOver;
	bool screenPushed;
	bool success;
	bool firstSquareVisible;
	bool gameStarted; //hopefully temporary
	bool firstGame;
	bool firstGameCleanup;
	
	//BitmapFontAtlas *scoreLabel;
	CCLabel *scoreLabel;
	CCLabel *endScoreLabel;
	CCLabel *highScoreLabel;
	
	CCBitmapFontAtlas *missLabel;
	
	CCSprite *logo;
	CCSprite *background;
	CCMenu *menu;
	float quitCounter;
	float quitTimer;
	float cloudHeight;
	bool quit;
	CCLabel *scoreDescLabel;
	CCLabel *highScoreDescLabel;
	
	NSUserDefaults *userDefaults;
		
}

-(void)mainLoop:(ccTime)dt;
-(void)changeColor;
-(void)checkCircleRange;
-(int)calculateScore:(float)x;
-(void)initGameVariables;

@end
