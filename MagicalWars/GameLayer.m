//
//  GameLayer.m
//  MagicalWars
//
//  Created by BulletHermit on 13-8-27.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "GameLayer.h"
#import "Helper.h"
#import "TileData.h"
#import "constant.h"
#import "Unit.h"
@implementation GameLayer
@synthesize tileMap,tileDataArray,selectedUnit;
-(id) init
{
    if (self = [super init]) {
        self.isTouchEnabled = YES;

        p1Units = [[NSMutableArray alloc] initWithCapacity:3];
         p2Units = [[NSMutableArray alloc] initWithCapacity:3];
        selectedUnit = nil;
        [self createTileMap];
        [self loadUnits:OwnerPlayer];
        [self loadUnits:OwnerEnemy];
    }
    return self;
}
-(void)createTileMap
{
    //init tile map
    tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"Map01.tmx"];
    tileMap.position = ccp(0,0);
    [self addChild:tileMap z:0];
    [self centerAt:ccp(19,10) blink:YES];

    //get bg layer
    bgLayer = [tileMap layerNamed:@"Background"];
    fgLayer = [tileMap layerNamed:@"Foreground"];
    //init tile data array
    tileDataArray = [[NSMutableArray alloc ] initWithCapacity:5];
    for (int i=0; i<tileMap.mapSize.height; ++i) {
        for (int j=0; j<tileMap.mapSize.width; ++j) {
            int movementCost = 1;
            NSString* type = nil;
            int tileGid = [bgLayer tileGIDAt:ccp(j,i)];
            if (tileGid) {
                NSDictionary* property = [tileMap propertiesForGID:tileGid];
                movementCost = [[property valueForKey:@"MovementCost"] intValue];
                type = [property valueForKey:@"TileType"] ;
            }
            tileGid = [fgLayer tileGIDAt:ccp(j, i)];
            if (tileGid) {
                NSDictionary* property = [tileMap propertiesForGID:tileGid];
                movementCost = [[property valueForKey:@"MovementCost"] intValue];
                type = [property valueForKey:@"TileType"] ;
            }
            
            TileData* tileData = [TileData nodeWithTheGame:self movementCost:movementCost position:ccp(j,i) tileType:type];
            
            [tileDataArray addObject:tileData];
        }
    }

}
-(void) loadUnits:(Owner )owner
{
    CCTMXObjectGroup* objectGroup;
    NSMutableArray* units=nil;
    if (owner==OwnerPlayer) {
        units =p1Units;
        objectGroup = [tileMap objectGroupNamed:[NSString stringWithFormat:@"Units_P%d",1]];
    }
    if (owner==OwnerEnemy) {
        units = p2Units;
        objectGroup = [tileMap objectGroupNamed:[NSString stringWithFormat:@"Units_P%d",2]];
    }
    for (NSMutableDictionary *dict in [objectGroup objects]) {
        
        NSString * type = [dict valueForKey:@"Type"];
        NSString* className = [NSString stringWithFormat:@"%@",type];
        Class theClass = NSClassFromString(className);
        
        Unit* unit=[Unit unitWithGame:self tileDict:dict owner:owner];
        [self addChild:unit];
        [units addObject:unit];
    }
    
}

#pragma -mark Helper
-(int) spriteScale
{
    if (IS_HD) {
        return 2;
    }
    return 1;
}
-(int)  getTileHeightForRetina
{
    if (IS_HD) {
        return TILE_HEIGHT_HD;
    }
    return TILE_HEIGHT;
}
-(CGPoint) tileCoordForPosition:(CGPoint)position
{
    CGSize tileSize = CGSizeMake(tileMap.tileSize.width, tileMap.tileSize.height);
    if (IS_HD) {
        tileSize = CGSizeMake(tileMap.tileSize.width/2  , tileMap.tileSize.height/2);
    }
    int x =  (position.x/tileSize.width);
    int y = (tileMap.mapSize.height*tileSize.height-position.y)/tileSize.height;
    return ccp(x,y);
}
-(CGPoint) positionInScreenFor:(CGPoint)pos
{
    CGPoint  position = ccpAdd(pos, self.position);
    return position;
}
-(CGPoint) tileCoordForTouch:(UITouch*)touch
{
    CGPoint location = [touch locationInView:[touch view]];
    location=[[CCDirector sharedDirector] convertToGL:location];
    CGPoint  position = ccpSub(location, self.position);
    CGSize tileSize = CGSizeMake(tileMap.tileSize.width, tileMap.tileSize.height);
    if (IS_HD) {
        tileSize = CGSizeMake(tileMap.tileSize.width/2  , tileMap.tileSize.height/2);
    }
    int x =  (position.x/tileSize.width);
    int y = (tileMap.mapSize.height*tileSize.height-position.y)/tileSize.height;
    return ccp(x,y);
    
}
-(CGPoint) positionForTileCoord:(CGPoint)coord
{
    
    CGSize tileSize = CGSizeMake(tileMap.tileSize.width, tileMap.tileSize.height);
    if (IS_HD) {
        tileSize = CGSizeMake(tileMap.tileSize.width/2  , tileMap.tileSize.height/2);
    }
    int x = coord.x*tileSize.width+tileSize.width/2;
    int y = (tileMap.mapSize.height-coord.y)*tileSize.height -tileSize.height/2;
    return ccp(x,y);
}
-(NSMutableArray*)getTilesNextToTile:(CGPoint)tileCoord
{
    NSMutableArray* tiles = [NSMutableArray arrayWithCapacity:4];
    if (tileCoord.y+1<tileMap.mapSize.height)
        [tiles addObject:[NSValue valueWithCGPoint:ccp(tileCoord.x,tileCoord.y+1)]];
    if (tileCoord.x+1<tileMap.mapSize.width)
        [tiles addObject:[NSValue valueWithCGPoint:ccp(tileCoord.x+1,tileCoord.y)]];
    if (tileCoord.y-1>=0)
        [tiles addObject:[NSValue valueWithCGPoint:ccp(tileCoord.x,tileCoord.y-1)]];
    if (tileCoord.x-1>=0)
        [tiles addObject:[NSValue valueWithCGPoint:ccp(tileCoord.x-1,tileCoord.y)]];
    return tiles;
}
-(TileData*)getTileData:(CGPoint)coord
{
    for (TileData* data in tileDataArray) {
        if (CGPointEqualToPoint(data.position, coord)) {
            return data;
        }
    }
    return nil;
}
#pragma -mark TileMap Paint
-(BOOL) paintMovementTile:(TileData *)td color:(ccColor3B)color
{
    if (!td.selectedForMovement) {
        td.selectedForMovement = YES;
        CCSprite* tile = [bgLayer tileAt:td.position];
        [tile setColor:color];
        return YES;
    }
    return NO;
    
}
-(void) unPaintMovementTile:(TileData *)td
{
    CCSprite* tile = [bgLayer tileAt:td.position];
    [tile setColor:ccWHITE];
}
#pragma -mark TileMap Check
-(Unit*) otherUnitInTile:(TileData *)td
{
    for (Unit* u in p1Units) {
        
        if(CGPointEqualToPoint([self tileCoordForPosition:u.myPosition], td.position))
            return u;
    }
    for (Unit* u in p2Units) {
        if(CGPointEqualToPoint([self tileCoordForPosition:u.myPosition], td.position))
            return u;
    }
    return nil;
}
-(Unit*) otherEnemyUnitInTile:(TileData *)td forOwner:(Owner)owner
{
//    if (owner == 1) {
//        for (Unit* u in p2Units) {
//            CGPoint uPos = [self tileCoordForPosition:u.mySprite.position];
//            if(CGPointEqualToPoint(uPos, td.position))
//                return u;
//        }
//    }else if (owner ==2)
//    {
//        for (Unit* u in p1Units) {
//            if(CGPointEqualToPoint([self tileCoordForPosition:u.mySprite.position], td.position))
//                return u;
//        }
//    }
    return nil;
}

#pragma -mark TouchHandle
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for( UITouch *touch in touches ) {
		CGPoint location = [Helper locationFromTouch:touch];
        touchBeginPoint=location;
        
	}
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for( UITouch *touch in touches ) {
        CGPoint location = [Helper locationFromTouch:touch];
        CGPoint myPosition = self.position;
        Float32 deltaDistanceX = touchBeginPoint.x-location.x;
        Float32 deltaDistanceY = touchBeginPoint.y - location.y;
        myPosition.x -=  deltaDistanceX;
        myPosition.y -= deltaDistanceY;
        touchBeginPoint = location;
        CGSize screenSize = [[CCDirectorIOS sharedDirector] winSize];
        myPosition.x =  MIN(0,myPosition.x);
        myPosition.x = MAX(-1.0*(tileMap.mapSize.width*tileMap.tileSize.width-screenSize.width), myPosition.x);
        myPosition.y = MIN(0, myPosition.y);
        myPosition.y = MAX(-1.0*(tileMap.mapSize.height*tileMap.tileSize.height-screenSize.height), myPosition.y);
        self.position = myPosition;

	}
}
-(void) centerAt:(CGPoint) tilePos blink:(BOOL)isBlink
{
    if (tilePos.x>=0&&tilePos.x<tileMap.mapSize.width
        &&tilePos.y>=0&&tilePos.y<tileMap.mapSize.height) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint center = ccp(winSize.width*0.5, winSize.height*0.5);
        
        CGPoint delta = ccpSub( center,[Helper openGLPosFromTileMap:tileMap tilePos:tilePos]);
        CGPoint origin = self.position;
        origin = ccpAdd(origin, delta);
        
        origin.x =  MIN(0,origin.x);
        origin.x = MAX(-1.0*(tileMap.mapSize.width*tileMap.tileSize.width-winSize.width), origin.x);
        origin.y = MIN(0, origin.y);
        origin.y = MAX(-1.0*(tileMap.mapSize.height*tileMap.tileSize.height-winSize.height), origin.y);
        self.position = origin;
    }
}
-(void)dealloc
{
    [tileDataArray release];
    tileDataArray = nil;
    [p1Units release];
    p1Units = nil;
    [p2Units  release];
    p2Units = nil;
    [super dealloc];
}
@end
