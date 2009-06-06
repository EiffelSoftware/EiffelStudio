/*
indexing
	description: "C features for OBJC_CALLBACK_MARSHAL"
	date: "$Date: 2009-04-26 22:46:55 +0200 (So, 26 Apr 2009) $"
	revision: "$Revision: 78382 $"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include "objc_callback_marshal.h"

EIF_OBJECT callback_object;
boolCallbackTYPE callback_bool;
voidPtrCallbackTYPE callback_void_ptr;

void bridge_void (id self, SEL name)
{
	//callback_void ( eif_access (callback_object) );
}

void bridge_void_ptr (id self, SEL name, void* arg1)
{
	return callback_void_ptr ( eif_access (callback_object), self, name, arg1 );
}

BOOL bridge_bool (id self, SEL name)
{
	return callback_bool ( eif_access (callback_object), self, name );
}

void connect_callbacks (EIF_OBJECT a_callback_object, boolCallbackTYPE a_callback_bool, voidPtrCallbackTYPE a_callback_void_ptr) {
	callback_object = eif_adopt (a_callback_object);
	callback_bool   = a_callback_bool;
	callback_void_ptr = a_callback_void_ptr;
}
