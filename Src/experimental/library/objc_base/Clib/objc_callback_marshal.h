/*
indexing
	description: "C features for OBJC_CALLBACK_MARSHAL"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _OBJC_CALLBACK_MARSHAL_H_INCLUDED_
#define _OBJC_CALLBACK_MARSHAL_H_INCLUDED_

#include <eif_eiffel.h>
#include <objc/runtime.h>

BOOL bridge_bool (id self, SEL name);
void bridge_void_ptr (id self, SEL name, void* arg1);

typedef EIF_BOOLEAN (*boolCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER);
typedef void (*voidPtrCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER);

void connect_callbacks (EIF_OBJECT a_callback_object, boolCallbackTYPE a_callback_bool, voidPtrCallbackTYPE a_callback_void_ptr);

#endif
