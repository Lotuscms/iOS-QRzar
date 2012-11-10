//
//  JZRankTableCellCustomView.h
//  QRZar
//
//  Created by Conor Brady on 07/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGamePlayers.h"

@interface JZRankTableCellCustomView : UIView{
	JZGamePlayers* _player;
	int _row;
}

@property (nonatomic, retain) JZGamePlayers* player;
@property int row;

-(id)initWithFrame:(CGRect)frame andPlayer:(JZGamePlayers*)player rowNumber:(int)row;

@end
