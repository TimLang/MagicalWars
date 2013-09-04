//
//  TileData.h
//  TurnWars
//
//  Created by Akira on 13-7-2.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"
@class GameLayer;
@interface TileData : CCNode {
    GameLayer* theGame;
    BOOL selectedForMovement;
    BOOL selectedForAction;
    int movementCost;
    CGPoint position;
    TileData* parentTile;
    TileData* parentActionTile;
    int hScore;
    int gScore;
    int fScore;
    NSString* tileType;
    
}
@property (nonatomic,readwrite) CGPoint position;

@property (nonatomic,assign) TileData* parentTile;
@property (nonatomic,assign) TileData* parentAttackTile;
@property (nonatomic,assign) NSString* tileType;
@property (nonatomic,readwrite) BOOL selectedForAction;
@property (nonatomic,readwrite) BOOL selectedForMovement;
@property (nonatomic,readwrite) int movementCost;
@property (nonatomic,readwrite) int hScore;
@property (nonatomic,readwrite) int gScore;


+(id) nodeWithTheGame:(GameLayer* )_game movementCost:(int) _cost position:(CGPoint)_pos tileType:(NSString*)_type;
-(id) initWithTheGame:(GameLayer* )_game movementCost:(int) _cost position:(CGPoint)_pos tileType:(NSString*)_type;
-(int) getGScore;
-(int) getGScoreForAction;
-(int) fScore;



@end
