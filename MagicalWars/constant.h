//
//  constant.h
//  MagicalWars
//
//  Created by BulletHermit on 13-8-27.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#ifndef MagicalWars_constant_h
#define MagicalWars_constant_h
typedef enum
{
    OwnerPlayer,
    OwnerEnemy,
    OwnerNeutral,
}Owner;
struct CharState
{
    int sleep;
    int locked;
    int poison;
    int silent;
} ;
typedef struct CharState CharState;

static inline CharState CharStateMake(int _sleep,int _locked,int _poison,int _silent)
{
  
    
     CharState cs;
     cs.sleep = _sleep;
     cs.locked = _locked;
     cs.poison = _poison;
     cs.silent = _silent;
     
     return cs;
     
}
typedef enum
{
    kTagLayerGame=0,
    kTagLayerUI,
} kTagLayer;
#define IS_HD ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.0f)
#define TILE_HEIGHT 32
#define TILE_HEIGHT_HD 64

#endif
