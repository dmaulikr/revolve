//
//  MainMenuScene.h
//  Revolve
//
//  Created by Johan Halin on 01.02.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "cocos2d.h"

@interface MainMenuScene : CCScene {

	CCSprite *defaultpng;
	CCSprite *brown1;
	CCSprite *brown2;
	CCSprite *brown3;
	CCSprite *brown4;
	CCSprite *menulogo;
	CCSprite *background;
	
	float timer;
	float loadTimer;
	float cloudHeight;
	
	int loadLevel;
	int counter;
	
	CCLabel *loadingLabel;
	
	CCMenu *menu;
	
}

-(void)mainLoop:(ccTime)dt;

@end
