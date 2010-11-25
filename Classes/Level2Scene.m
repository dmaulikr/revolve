//
//  Level2Scene.m
//  Revolve
//
//  Created by Johan Halin on 01.02.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import "Level2Scene.h"


@implementation Level2Scene

-(id)init {
	
	self = [super init];
	if (self != nil) {
		
		game = [Level2Layer node];
		[self addChild:game];
		
	}
	return self;
	
}

@end
