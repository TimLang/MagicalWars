//
//  MoveComponent.m
//  MagicalWars
//
//  Created by BulletHermit on 13-8-28.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "MoveComponent.h"
#import "TileData.h"
#import "Unit.h"
@implementation MoveComponent
-(id) init
{
    if (self = [super init]) {
        spClosedSteps = [[NSMutableArray alloc] init];
        spOpenSteps = [[NSMutableArray alloc] init];
        movementPath = [[NSMutableArray alloc] init];
    }
    return  self;
}
-(void) markPossibleMovementWithRange:(int ) range
{
    Unit* parentUnit = (Unit*)self.parent;
    GameLayer* theGame = parentUnit.gameLayer;
    //1.add origin tile to open and closed steps and paint it
    TileData* originTile  = [theGame getTileData:[theGame tileCoordForPosition:[parentUnit myPosition]]];
    
    [spOpenSteps addObject:originTile];
    [spClosedSteps addObject:originTile];
    [theGame paintMovementTile:originTile color:ccBLUE];

    
    //2.Recyle:Find all tile useful
    int i=0;
    do {
        //2.1 get 4 neightbour tiles from current(spOpenSteps[i])
        TileData* currentTileDate = [spOpenSteps objectAtIndex:i];
        NSMutableArray* tiles = [theGame getTilesNextToTile:currentTileDate.position];
        //2.2 judge if each neighbour could be useful
        //------Y:add in open,closedSteps and paint it
        //------N:if the tile is out of movement range,searched, an enemy on it , counldn't be stand,then ignore it
        for (NSValue* _neighbourTileValue in tiles) {
            TileData* neighbourTile = [theGame getTileData:[_neighbourTileValue CGPointValue]];
            //2.2.1 judge if it has been searched
            if ([spClosedSteps containsObject:neighbourTile]) {
                continue;
            }
            //2.2.2 judge if it has been an enemy standed
            if ([theGame otherEnemyUnitInTile:neighbourTile forOwner:parentUnit.owner]) {
                continue;
            }
            //2.2.3 judge if it couldn't be standed
            if (![parentUnit canWalkOverTile:neighbourTile]) {
                continue;
            }
            //2.2.4 judge if it is out of movement range
            neighbourTile.parentTile=nil;
            neighbourTile.parentTile = currentTileDate;
            [theGame paintMovementTile:neighbourTile color:ccBLUE];

            if ([neighbourTile getGScore] >range) {
                continue;
            }
            
            //2.2.5 add and paint
            
            [spClosedSteps addObject:neighbourTile];
            [spOpenSteps addObject:neighbourTile];
        }
        i++;
    } while (i<[spOpenSteps count]);
    
    [spClosedSteps removeAllObjects];
    [spOpenSteps removeAllObjects];

}
-(void) unMarkPossibleMovement
{
    Unit* parentUnit = (Unit*)self.parent;
    GameLayer* theGame = parentUnit.gameLayer;
    for (TileData* td in theGame.tileDataArray) {
        [theGame unPaintMovementTile:td];
        td.parentTile = nil;
        td.selectedForMovement = NO;
    }
}
-(NSMutableArray*) pathFrom:(TileData *)p1 to:(TileData *)p2
{
    Unit* parentUnit = (Unit*)self.parent;
    GameLayer* theGame = parentUnit.gameLayer;
    //1.insert startTile to OpenList
    [self insertOrderedInOpenSteps:p1];
    //2.Cycle:Find the target tile and link paths
    do {
        //2.1 get a tile(currentTile) from spopenSteps[0]
        TileData* currentTile = [spOpenSteps objectAtIndex:0];
        [spClosedSteps addObject:currentTile];
        [spOpenSteps removeObjectAtIndex:0];
        //2.2 judge if currentTile is the target tile
        if (CGPointEqualToPoint(currentTile.position, p2.position)) {
            //construct path and return it
            [movementPath removeAllObjects];
            TileData* tile = currentTile;
            do {
                if (tile.parent!=nil) {
                    [movementPath insertObject:tile atIndex:0];
                }
                tile = tile.parentTile;
            } while (tile!=nil);
            
            [spClosedSteps removeAllObjects];
            [spOpenSteps removeAllObjects];
            return movementPath;
        }
        //2.3 search the 4 neighbours tile
        NSMutableArray* tiles = [theGame getTilesNextToTile: currentTile.position];
        for (NSValue* tilevalue in tiles) {
            CGPoint neighbourCoord = [tilevalue CGPointValue];
            TileData* neighbourTile = [theGame getTileData:neighbourCoord];
            //2.4 judge if it has been in closeList or standed a enemy or is unwalkable ,then continue
            if ([spClosedSteps containsObject:neighbourTile]) {
                continue;
            }
            if ([theGame otherEnemyUnitInTile:neighbourTile forOwner:parentUnit.owner]) {
                continue;
            }
            if (![parentUnit canWalkOverTile:neighbourTile]) {
                continue;
            }
            //2.5 judge if it is open list
            int movementCost = [self costToMoveFromTile:currentTile toAdjacentTile:neighbourTile];
            int index = [spOpenSteps indexOfObject:neighbourTile];
            if (index==NSNotFound) {
                //2.5.1 Yes:alter its parent,compute its gScore and hScore,insert to open list
                neighbourTile.parentTile = nil;
                neighbourTile.parentTile = currentTile;
                neighbourTile.gScore = currentTile.gScore+movementCost;
                neighbourTile.hScore = [self computeHScoreFromCoord:currentTile.position toCoord:neighbourTile.position];
                [self insertOrderedInOpenSteps:neighbourTile];
                continue;
            }
            else
            {
                //2.5.2 NO: alter it by the gScore which former in openlist and the gScore which it from current to here
                neighbourTile = [spOpenSteps objectAtIndex:index];
                if ((currentTile.gScore+movementCost) <neighbourTile.gScore) {
                    neighbourTile.gScore = currentTile.gScore+movementCost;
                    [spOpenSteps removeObjectAtIndex:index];
                    [self insertOrderedInOpenSteps:neighbourTile];
                }
            }
        }
    } while ([spOpenSteps count]>0);
    return nil;

}

-(void) insertOrderedInOpenSteps:(TileData *)td
{
    int tdFScore = [td fScore];
    int count = [spOpenSteps count];
    int i=0;
    for (; i<count; ++i) {
        if (tdFScore<[[spOpenSteps objectAtIndex:i] fScore]) {
            break;
        }
    }
    [spOpenSteps insertObject:td atIndex:i];
}


-(int)computeHScoreFromCoord:(CGPoint)fromCoord toCoord:(CGPoint)toCoord {
    // Here you use the Manhattan method, which calculates the total number of steps moved horizontally and vertically to reach the
    // final desired step from the current step, ignoring any obstacles that may be in the way
    return abs(toCoord.x - fromCoord.x) + abs(toCoord.y - fromCoord.y);
}

-(int)costToMoveFromTile:(TileData *)fromTile toAdjacentTile:(TileData *)toTile {
    // Because you can't move diagonally and because terrain is just walkable or unwalkable the cost is always the same.
    // But it has to be different if you can move diagonally and/or if there are swamps, hills, etc...
    return 1;
}

-(void) dealloc
{
    [spOpenSteps release];
    spOpenSteps = nil;
    [spClosedSteps release];
    spClosedSteps = nil;
    [movementPath release];
    movementPath = nil;
    [super dealloc];
}
@end
