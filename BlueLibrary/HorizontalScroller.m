//
//  HorizontalScroller.m
//  BlueLibrary
//
//  Created by Fernando Garcia Corrochano on 5/11/14.
//  Copyright (c) 2014 Eli Ganem. All rights reserved.
//

#import "HorizontalScroller.h"

// 1 Define constants to make it easy to modify the layout at design time. The view’s dimensions inside the scroller will be 100 x 100 with a 10 point margin from its enclosing rectangle.
#define VIEW_PADDING 10
#define VIEW_DIMENSIONS 100
#define VIEWS_OFFSET 100

// 2 HorizontalScroller conforms to the UIScrollViewDelegate protocol. Since HorizontalScroller uses a UIScrollView to scroll the album covers, it needs to know of user events such as when a user stops scrolling.
@interface HorizontalScroller () <UIScrollViewDelegate>
@end

// 3 Create the scroll view containing the views.
@implementation HorizontalScroller{
	UIScrollView *scroller;
}

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self){
		scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		scroller.delegate = self;
		[self addSubview:scroller];
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
		[scroller addGestureRecognizer:tapRecognizer];
	}
	return self;
}

- (void)scrollerTapped:(UITapGestureRecognizer*)gesture{
	CGPoint location = [gesture locationInView:gesture.view];
	// we can't use an enumerator here, because we don't want to enumerate over ALL of the UIScrollView subviews.
	// we want to enumerate only the subviews that we added
	for (int index=0; index<[self.delegate numberOfViewsForHorizontalScroller:self]; index++){
		UIView *view = scroller.subviews[index];
		if (CGRectContainsPoint(view.frame, location)){
			[self.delegate horizontalScroller:self clickedViewAtIndex:index];
			[scroller setContentOffset:CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0) animated:YES];
			break;
		}
	}
}

- (void)reload{
	
	// 1 - nothing to load if there's no delegate
	if (self.delegate == nil) return;
 
	// 2 - remove all subviews
	[scroller.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[obj removeFromSuperview];
	}];
 
	// 3 - xValue is the starting point of the views inside the scroller
	CGFloat xValue = VIEWS_OFFSET;
	for (int i=0; i<[self.delegate numberOfViewsForHorizontalScroller:self]; i++){
		// 4 - add a view at the right position
		xValue += VIEW_PADDING;
		UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
		view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
		[scroller addSubview:view];
		xValue += VIEW_DIMENSIONS+VIEW_PADDING;
	}
 
	// 5 Once all the views are in place, set the content offset for the scroll view to allow the user to scroll through all the albums covers.
	[scroller setContentSize:CGSizeMake(xValue+VIEWS_OFFSET, self.frame.size.height)];
 
	// 6 - if an initial view is defined, center the scroller on it
	if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]){
		NSInteger initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
		[scroller setContentOffset:CGPointMake(initialView*(VIEW_DIMENSIONS+(2*VIEW_PADDING)), 0)
											animated:YES];
	}
}

- (void)didMoveToSuperview{
	[self reload];
}

- (void)centerCurrentView{
	int xFinal = scroller.contentOffset.x + (VIEWS_OFFSET/2) + VIEW_PADDING;
	int viewIndex = xFinal / (VIEW_DIMENSIONS+(2*VIEW_PADDING));
	xFinal = viewIndex * (VIEW_DIMENSIONS+(2*VIEW_PADDING));
	[scroller setContentOffset:CGPointMake(xFinal,0) animated:YES];
	[self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (!decelerate){
		[self centerCurrentView];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	[self centerCurrentView];
}

@end
