//
//  Unit.m
//  MagicalWars
//
//  Created by BulletHermit on 13-8-28.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "Unit.h"
#import "MoveComponent.h"
#import "AnimationComponent.h"
#import "GameLayer.h"
#import "TileData.h"
#import "GameUILayer.h"
@implementation Unit
@synthesize gameLayer,owner;
+(id) unitWithGame:(GameLayer *)_game tileDict:(NSMutableDictionary *)tileDict owner:(Owner)_owner
{
    return [[[self alloc] initWithGame:_game tileDict:tileDict owner:_owner] autorelease];
}
-(id) initWithGame:(GameLayer *)_game tileDict:(NSMutableDictionary *)tileDict owner:(Owner)_owner
{
    if (self = [super init]) {
        
        gameLayer = _game;
         owner = _owner;
        moveState = MoveStateDown;
        logicalState = LogicalStateReady;
        moveCom = [MoveComponent node];
        [self addChild:moveCom];
        charState = CharStateMake(0, 0, 0, 0);
        
        [self creatSprite:tileDict];
    }
    return self;
}
-(void) creatSprite:(NSMutableDictionary *)dict 
{
    int x = [[dict valueForKey:@"x"] intValue]/[gameLayer spriteScale];
    int y = [[dict valueForKey:@"y"] intValue]/[gameLayer spriteScale];
    int width = [[dict valueForKey:@"width"] intValue]/ [gameLayer spriteScale];
    int height = [[dict valueForKey:@"height"] intValue]/ [gameLayer spriteScale];
    //int heightInTile = height/[theGame getTileHeightForRetina];
    x +=width/2;
    y+=height/2;
    mySprite = [AnimationComponent animationWithAnimName:@"Knight"];
    [self addChild:mySprite z:1];
    mySprite.userData = self;
    mySprite.position = ccp(x,y);
}

-(BOOL)canWalkOverTile:(id)tileData
{
    TileData* td = (TileData*)tileData;
    if ([td.tileType isEqual: @"Balk"]) {
        return NO;
    }
    return YES;
}
-(void) onEnter
{
    [[[CCDirectorIOS sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
    [super onEnter];
}
-(void) onExit
{
    [[[CCDirectorIOS sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}
-(BOOL) containsTouchLocation:(UITouch*)touch
{
    if (CGRectContainsPoint([mySprite boundingBox], [self convertTouchToNodeSpaceAR:touch])) {
        return YES;
    }
    return NO;
    
}
-(CGPoint)myPosition
{
    return mySprite.position;
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (logicalState ==LogicalStateMovable ) {
        TileData* td = [gameLayer getTileData:[gameLayer tileCoordForTouch:touch]];

        if ((td.selectedForMovement && ![gameLayer otherUnitInTile:td]))
        {
            TileData* originTile  = [gameLayer getTileData:[gameLayer tileCoordForPosition:[self myPosition]]];
            NSMutableArray* path=[moveCom pathFrom:originTile to:td];
            [mySprite moveByPath:path];
            logicalState = LogicalStateAction;
        }
    }
    if (![self containsTouchLocation:touch]) {
        return NO;
    }

    if (charState.sleep==0&&charState.locked == 0&&logicalState==LogicalStateReady) {
        [self toMovable];
    }

    return YES;
}
#pragma -mark Logical Segment/Users/Bullet/Documents/Cocos2dProject/MagicalWars/MagicalWars/Unit.m
-(void) toMovable
{
   //release unit
    if (gameLayer.selectedUnit) {
        [gameLayer.selectedUnit toCancel];
    }
    //set selectedunit to self
     gameLayer.selectedUnit = nil;
    gameLayer.selectedUnit = self;
    CCAction*  followCamera= [CCFollow actionWithTarget:mySprite worldBoundary:CGRectMake(0, 0, 960, 960)];
    followCamera.tag = kTagActionFollow;
    //[gameLayer runAction: followCamera ];
    
    [moveCom markPossibleMovementWithRange:3];

    logicalState=LogicalStateMovable;
}
-(void) toAction
{
    [moveCom unMarkPossibleMovement];
    //display action menu
    [[GameUILayer shareGameUILayer] displayActionMenu];
    
    logicalState = LogicalStateAction;
}
-(void) toSubAction
{
    //hide action menu
        [gameLayer stopActionByTag:kTagActionFollow];
    //display sub action menu
}
-(void) toEnd
{
    //set unit end
    [mySprite turnOver];
    [gameLayer stopActionByTag:kTagActionFollow];
    logicalState = LogicalStateEnd;
}
-(void) toCancel
{
    //unmark possible movement
     [moveCom unMarkPossibleMovement];
    logicalState = LogicalStateReady;
}
@end
