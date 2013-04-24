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
#include <Foundation/NSMethodSignature.h>

void bridge_void (id self, SEL name);
BOOL bridge_bool (id self, SEL name);
void bridge_void_ptr (id self, SEL name, void* arg1);
void bridge_void_ptr_ptr (id self, SEL name, void* arg1, void* arg2);
void bridge_void_general (id self, SEL name, ...);

typedef void (*voidCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER);
typedef EIF_BOOLEAN (*boolCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER);
typedef void (*voidPtrCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER);
typedef void (*voidPtrPtrCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER);
typedef void (*voidGeneralCallbackTYPE) (EIF_REFERENCE, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_INTEGER);

void connect_callbacks (EIF_OBJECT a_callback_object,
			voidCallbackTYPE a_callback_void,
			boolCallbackTYPE a_callback_bool,
			voidPtrCallbackTYPE a_callback_void_ptr,
			voidPtrPtrCallbackTYPE a_callback_void_ptr_ptr,
			voidGeneralCallbackTYPE a_callback_void_general);

#endif
