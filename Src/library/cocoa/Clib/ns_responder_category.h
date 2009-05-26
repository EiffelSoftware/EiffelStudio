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

#endif
