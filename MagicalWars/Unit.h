//
//  Unit.h
//  MagicalWars
//
//  Created by BulletHermit on 13-8-28.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "constant.h"




typedef enum
{
    MoveStateUp=0,
    MoveStateDown,
    MoveStateLeft,
    MoveStateRight,
} MoveState;
typedef enum
{
    LogicalStateReady=0,
    LogicalStateMovable,
    LogicalStateAction,
    LogicalStateSubAction,
    LogicalStateEnd,
    
} LogicalState;
typedef enum
{
    kTagActionFollow=0,
    
} kTagAction;

@class GameLayer;
@class MoveComponent;
@class AnimationComponent;
@class TileData;
@interface Unit : CCNode<CCTargetedTouchDelegate> {
    GameLayer* gameLayer;
    MoveComponent* moveCom;
    AnimationComponent* mySprite;
    Owner* owner;
    MoveState moveState;
    CharState charState;
    LogicalState logicalState;

}
@property (readonly,nonatomic) GameLayer* gameLayer;
@property (readonly,nonatomic) Owner* owner;
+(id) unitWithGame:(GameLayer*)_game tileDict:(NSMutableDictionary*)tileDict owner:(Owner) _owner;;
-(BOOL) canWalkOverTile:(TileData*)tileData;
-(CGPoint)myPosition;

-(void) toCancel;
-(void) toAction;
-(void) toEnd;
@end
