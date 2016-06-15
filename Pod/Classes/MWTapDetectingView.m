//
//  UIViewTap.m
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import "MWTapDetectingView.h"

@implementation MWTapDetectingView

- (id)init {
	if ((self = [super init])) {
		self.userInteractionEnabled = YES;
        [self setupGestureRecognizer];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
        [self setupGestureRecognizer];
	}
	return self;
}

- (void)setupGestureRecognizer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleHandle:)];
    [self addGestureRecognizer:singleTap];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleHandle:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleHandle:)];
    tripleTap.numberOfTapsRequired = 3;
    [self addGestureRecognizer:tripleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [doubleTap requireGestureRecognizerToFail:tripleTap];
}

- (void)singleHandle:(UITapGestureRecognizer *)recognizer {
    if ([_tapDelegate respondsToSelector:@selector(view:singleTapRecognizer:)])
        [_tapDelegate view:self singleTapRecognizer:recognizer];
}

- (void)doubleHandle:(UITapGestureRecognizer *)recognizer {
    if ([_tapDelegate respondsToSelector:@selector(view:doubleTapRecognizer:)])
        [_tapDelegate view:self doubleTapRecognizer:recognizer];
}

- (void)tripleHandle:(UITapGestureRecognizer *)recognizer {
    if ([_tapDelegate respondsToSelector:@selector(view:tripleTapRecognizer:)])
        [_tapDelegate view:self tripleTapRecognizer:recognizer];
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *touch = [touches anyObject];
//	NSUInteger tapCount = touch.tapCount;
//	switch (tapCount) {
//		case 1:
//			[self handleSingleTap:touch];
//			break;
//		case 2:
//			[self handleDoubleTap:touch];
//			break;
//		case 3:
//			[self handleTripleTap:touch];
//			break;
//		default:
//			break;
//	}
//	[[self nextResponder] touchesEnded:touches withEvent:event];
//}

- (void)handleSingleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(view:singleTapDetected:)])
		[_tapDelegate view:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(view:doubleTapDetected:)])
		[_tapDelegate view:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(view:tripleTapDetected:)])
		[_tapDelegate view:self tripleTapDetected:touch];
}

@end
