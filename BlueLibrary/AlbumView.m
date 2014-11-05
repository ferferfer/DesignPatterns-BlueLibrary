//
//  AlbumView.m
//  BlueLibrary
//
//  Created by Fernando Garcia Corrochano on 5/11/14.
//  Copyright (c) 2014 Eli Ganem. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView{
	UIImageView *coverImage;
	UIActivityIndicatorView *indicator;
}

- (id)initWithFrame:(CGRect)frame albumCover:(NSString*)albumCover{
	self = [super initWithFrame:frame];
	if (self){
		
		self.backgroundColor = [UIColor blackColor];
		// the coverImage has a 5 pixels margin from its frame
		coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
		[self addSubview:coverImage];
		
		indicator = [[UIActivityIndicatorView alloc] init];
		indicator.center = self.center;
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		[indicator startAnimating];
		[self addSubview:indicator];
	}
	return self;
}

@end