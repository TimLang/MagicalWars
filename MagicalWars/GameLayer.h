//
//  GameLayer.h
//  MagicalWars
//
//  Created by BulletHermit on 13-8-27.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "constant.h"
@class TileData;
@class Unit;
@interface GameLayer : CCLayer {
    CCTMXTiledMap* tileMap;
    CCTMXLayer* bgLayer;
    CCTMXLayer* fgLayer;
    NSMutableArray* tileDataArray;
    CGPoint touchBeginPoint;
    NSMutableArray* p1Units;
    NSMutableArray* p2Units;
    Unit* selectedUnit;
}
@property (readonly,nonatomic)  CCTMXTiledMap* tileMap;
@property (readonly,nonatomic) NSMutableArray* tileDataArray;
@property (retain,nonatomic) Unit* selectedUnit;

-(int) spriteScale;
-(int)  getTileHeightForRetina;
-(CGPoint) tileCoordForPosition:(CGPoint)position;
-(CGPoint) tileCoordForTouch:(UITouch*)touch;
-(CGPoint) positionForTileCoord:(CGPoint)coord;
-(CGPoint) positionInScreenFor:(CGPoint)pos;

-(NSMutableArray*)getTilesNextToTile:(CGPoint)tileCoord;
-(TileData*)getTileData:(CGPoint)coord;
-(BOOL) paintMovementTile:(TileData*)td color:(ccColor3B)color;
-(void) unPaintMovementTile:(TileData*)td;
-(Unit*) otherEnemyUnitInTile:(TileData *)td forOwner:(Owner)owner;
-(Unit*) otherUnitInTile:(TileData *)td;

@end
