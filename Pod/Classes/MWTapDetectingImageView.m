//
//  UIImageViewTap.m
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import "MWTapDetectingImageView.h"

@implementation MWTapDetectingImageView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
        [self setupGestureRecognizer];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image {
	if ((self = [super initWithImage:image])) {
		self.userInteractionEnabled = YES;
        [self setupGestureRecognizer];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
	if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
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
    if ([_tapDelegate respondsToSelector:@selector(imageView:singleTapRecognizer:)])
        [_tapDelegate imageView:self singleTapRecognizer:recognizer];
}

- (void)doubleHandle:(UITapGestureRecognizer *)recognizer {
    if ([_tapDelegate respondsToSelector:@selector(imageView:doubleTapRecognizer:)])
        [_tapDelegate imageView:self doubleTapRecognizer:recognizer];
}

- (void)tripleHandle:(UITapGestureRecognizer *)recognizer {
    if ([_tapDelegate respondsToSelector:@selector(imageView:tripleTapRecognizer:)])
        [_tapDelegate imageView:self tripleTapRecognizer:recognizer];
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
	if ([_tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
		[_tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
		[_tapDelegate imageView:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(imageView:tripleTapDetected:)])
		[_tapDelegate imageView:self tripleTapDetected:touch];
}

@end
