//
//  IntroScene.h
//  Revolve
//
//  Created by Johan Halin on 05.02.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "MainMenuScene.h"

@interface IntroScene : CCScene {

	MainMenuScene *menuScene;
	CCSprite *defaultpng;
	int counter;
	
}

-(void)mainLoop:(ccTime)dt;

@end
