/*
indexing
	description: "C features for NS_VIEW"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_BUTTON_H_INCLUDED_
#define _NS_BUTTON_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef void (*mouseDownTYPE) (EIF_REFERENCE, EIF_POINTER);

@interface MyButton : NSButton {
	EIF_OBJECT callback_object;
	mouseDownTYPE callback_mouse_down;
}
	- (void)mouseDown: (NSEvent *)aEvent;
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_object andMethod:(mouseDownTYPE)a_method;
@end

#endif
