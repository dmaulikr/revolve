//
//  Level3Scene.m
//  Revolve
//
//  Created by Johan Halin on 01.02.2010.
//  Copyright 2010 Parasol. All rights reserved.
//

#import "Level3Scene.h"


@implementation Level3Scene

-(id)init {
	
	self = [super init];
	if (self != nil) {
		
		game = [Level3Layer node];
		[self addChild:game];
		
	}
	return self;
	
}

@end
