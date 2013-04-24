/*
indexing
	description: "C features for NS_WINDOW_DELEGATE"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_RESPONDER_CATEGORY_H_INCLUDED_
#define _NS_RESPONDER_CATEGORY_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef (*mouseDownTYPE) (EIF_REFERENCE, void *, void *);

@interface NSResponder (mouse)
	-(void)mouseDown:(NSEvent*)theEvent;
@end

EIF_REFERENCE setResponderCallback( EIF_REFERENCE callbackObject, mouseDownTYPE callbackMethod);

BOOL bridge_bool (id self, SEL name);
void bridge_void_ptr (id self, SEL name, void* arg1);

typedef EIF_BOOLEAN (*boolCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER);
typedef void (*voidPtrCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER);

void connect_callbacks (EIF_OBJECT a_callback_object, boolCallbackTYPE a_callback_bool, voidPtrCallbackTYPE a_callback_void_ptr);

#endif
