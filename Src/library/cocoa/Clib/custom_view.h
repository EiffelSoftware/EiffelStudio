/*
indexing
	description: "C features for NS_VIEW"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _CUSTOM_VIEW_H_INCLUDED_
#define _CUSTOM_VIEW_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef EIF_REFERENCE (*drawRectTYPE) (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER);

@interface CustomView : NSView {
	EIF_OBJECT callbackObject;
	drawRectTYPE callbackMethod;
}
	- (void)drawRect:(NSRect)dirtyRect;
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_object andMethod:(drawRectTYPE)a_method;
@end

#endif
