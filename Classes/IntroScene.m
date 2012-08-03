//
//  IntroScene.m
//  Revolve
//
//  Created by Johan Halin on 05.02.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import "IntroScene.h"


@implementation IntroScene

-(id)init {
	
	self = [super init];
	if (self != nil) {
		[self schedule:@selector(mainLoop:)];

		defaultpng = [[CCSprite spriteWithFile:@"Default.png"] retain];
		defaultpng.anchorPoint = CGPointZero; // HMM!
		defaultpng.scale = [[UIScreen mainScreen] scale] > 1 ? 0.5 : 1.0;
		[self addChild:defaultpng z:10];
		
		counter = 0;
	
	}
	return self;
	
}

-(void)mainLoop:(ccTime)dt {
	
	if(counter == 0) {
		counter++;
		[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:4 scene:[MainMenuScene node] withColor:ccc3(0,0,0)]];
	}
	
}


@end
