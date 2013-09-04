//
//  TileData.m
//  TurnWars
//
//  Created by Akira on 13-7-2.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TileData.h"


@implementation TileData

@synthesize tileType,position,parentTile,gScore,hScore,selectedForMovement,selectedForAction,movementCost,parentAttackTile;
+(id) nodeWithTheGame:(GameLayer *)_game movementCost:(int)_cost position:(CGPoint)_pos tileType:(NSString *)_type
{
    return [[[self alloc] initWithTheGame:_game movementCost:_cost position:_pos tileType:_type] autorelease];
}
-(id) initWithTheGame:(GameLayer *)_game movementCost:(int)_cost position:(CGPoint)_pos tileType:(NSString *)_type
{
    if (self = [super init]) {
        selectedForMovement=NO;
        theGame = _game;
        movementCost = _cost;
        position  =_pos;
        tileType = _type;
        parentTile = nil;
        parentActionTile=nil;
        [theGame addChild:self];
    }
    return self;
}

-(int)getGScore
{
    int parentScore=0;
    if (parentTile) {
        parentScore = [parentTile getGScore];
    }
    return movementCost+parentScore;

}
-(int) getGScoreForAction
{
    int parentScore = 0;
    if (parentActionTile) {
        CCLOG(@"self:%@,parent:%@",NSStringFromClass(self.class),NSStringFromCGPoint([parentActionTile position]));
        parentScore = [parentActionTile getGScoreForAction];
    }
    return 1+parentScore;
}
-(int) fScore
{
    return gScore+hScore;
    
}
-(NSString*) description
{
    return [NSString stringWithFormat:@"%@  pos=[%.0f;%.0f]  g=%d  h=%d  f=%d", [super description], self.position.x, self.position.y, self.gScore, self.hScore, [self fScore]];
}
@end
