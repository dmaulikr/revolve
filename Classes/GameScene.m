//
//  GameScene.m
//  Revolve
//
//  Created by Johan Halin on 16.12.2009.
//  Copyright 2009 Parasol. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(id)init {
	
	self = [super init];
	if (self != nil) {
		
		circles = [CircleLayer node];
		[self addChild:circles];
		
	}
	return self;
	
}

@end
