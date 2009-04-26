/*
indexing
	description: "C features for NS_WINDOW_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_WINDOW_DELEGATE_H_INCLUDED_
#define _NS_WINDOW_DELEGATE_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef EIF_REFERENCE (*windowDidResizeTYPE) (EIF_REFERENCE);

@interface WindowDelegate : NSObject {
	EIF_OBJECT callbackObject;
	windowDidResizeTYPE callbackMethod;
}
	- (void)windowDidResize:(NSNotification *)notification;
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)callbackObject andMethod:(windowDidResizeTYPE)callbackMethod;
@end

#endif
