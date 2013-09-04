//
//  MoveComponent.h
//  MagicalWars
//
//  Created by BulletHermit on 13-8-28.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Unit;
@class GameLayer;
@class TileData;
@interface MoveComponent : CCNode <CCTargetedTouchDelegate>{
    NSMutableArray* spOpenSteps;
    NSMutableArray* spClosedSteps;
    NSMutableArray* movementPath;
}
-(void) markPossibleMovementWithRange:(int ) range;
-(void) unMarkPossibleMovement;
-(NSMutableArray*) pathFrom:(TileData *)p1 to:(TileData *)p2;
@end
