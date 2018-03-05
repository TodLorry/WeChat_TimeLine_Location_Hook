//
//  Macro.h
//  Interaction
//
//  Created by albus on 2017/12/13.
//  Copyright © 2017年 albus. All rights reserved.
//

//#import "MacroOfTool.h"

#ifndef Macro_h
#define Macro_h

//是否是iPad
#define IS_iPAD [[UIDevice currentDevice].model isEqualToString:@"iPad"]
//是否是iPhoneX
#define IS_iPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//MapBox的token
#define MAPBOX_TOKEN @"pk.eyJ1IjoiYWxidXMxMjM0NTYiLCJhIjoiY2plNmprY3FzMDB2MzJ4bXpyNmplZTU4eiJ9.uWW1I06pjx_rw7bpFKcRdA"

#pragma mark 一些常量数字

//iPhoneX的HomeIndicator的高度
#define HomeIndicator_HEIGHT 34

//iPhoneX的状态栏栏增加的高度
#define ADDING_HEIGHT_OF_X_STATUS_BAR 24


#endif /* Macro_h */
