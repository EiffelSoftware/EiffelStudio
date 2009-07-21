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
voidCallbackTYPE callback_void;
voidPtrCallbackTYPE callback_void_ptr;
voidPtrPtrCallbackTYPE callback_void_ptr_ptr;
voidGeneralCallbackTYPE callback_void_general;

void bridge_void (id self, SEL name)
{
	callback_void ( eif_access (callback_object), self, name );
}

void bridge_void_ptr (id self, SEL name, void* arg1)
{
	callback_void_ptr ( eif_access (callback_object), self, name, arg1 );
}

void bridge_void_ptr_ptr (id self, SEL name, void* arg1, void* arg2)
{
	callback_void_ptr_ptr ( eif_access (callback_object), self, name, arg1, arg2);
}

BOOL bridge_bool (id self, SEL name)
{
	return callback_bool ( eif_access (callback_object), self, name );
}

void bridge_void_general (id self, SEL selector, ...) {
	int i, nargs;
	EIF_PROCEDURE p_make;		/* `make ' from MY_ARRAY [INTEGER] */
	EIF_PROCEDURE p_put;			/* `put' from MY_ARRAY [INTEGER] */
	EIF_PROCEDURE p_display;		/* `display' from MY_ARRAY [INTEGER] */
	EIF_TYPE_ID my_array_tid;	/* MY_ARRAY [INTEGER] type id */
	EIF_OBJECT o_array;		/* Protected indirection to an array of integers */

	va_list args;
	va_start (args, selector);
	Class currentClass = object_getClass (self);
	Method currentMethod = class_getInstanceMethod (currentClass, selector);

	NSMethodSignature* sig = [NSMethodSignature signatureWithObjCTypes: method_getTypeEncoding (currentMethod)];

	nargs = [sig numberOfArguments];
	printf("%s %s (%i Arguments, %s)\n",
	class_getName (currentClass),
	method_getName (currentMethod),
	nargs,
	method_getTypeEncoding (currentMethod));

	my_array_tid = eif_type_id ("MY_ARRAY[INTEGER]");	
	if (my_array_tid == EIF_NO_TYPE) 
			/* MY_ARRAY's type id not found. */
		eif_panic ("No type id.");

	p_make = eif_procedure ("make", my_array_tid);	
	p_display = eif_procedure ("display", my_array_tid);
	p_put = eif_procedure ("put", my_array_tid);

		/* o_array is a protected indirection 
		 * it has to be accessed with `eif_access'
		 * and freed with `eif_wean' */	
	o_array = eif_create (my_array_tid);

		/* Call `make (1, 10)' on new array */
	(p_make) (eif_access (o_array), 1, nargs);	

	for (i= 0; i < nargs; i++) {
		if (!strcmp("@", [sig getArgumentTypeAtIndex: i]) && i != 0) {
			void* arg = va_arg(args, void*);
			printf("    %i: %s  -> %x\n", i, [sig getArgumentTypeAtIndex: i], arg);
			(p_put) (eif_access (o_array), (EIF_POINTER) arg, i+1);
		} else if (!strcmp("i", [sig getArgumentTypeAtIndex: i])) {
			int arg = va_arg(args, int);
			printf("    %i: %s  -> %i\n", i, [sig getArgumentTypeAtIndex: i], arg);
			(p_put) (eif_access (o_array), (EIF_POINTER) arg, i+1);
		}
	}
	
	callback_void_general (eif_access (callback_object), self, selector, eif_access (o_array));
	
	va_end(args);
}

void connect_callbacks (EIF_OBJECT a_callback_object,
						voidCallbackTYPE a_callback_void,
						boolCallbackTYPE a_callback_bool,
						voidPtrCallbackTYPE a_callback_void_ptr,
						voidPtrPtrCallbackTYPE a_callback_void_ptr_ptr,
						voidGeneralCallbackTYPE a_callback_void_general) {
	callback_object = eif_adopt (a_callback_object);
	callback_bool = a_callback_bool;
	callback_void = a_callback_void;
	callback_void_ptr = a_callback_void_ptr;
	callback_void_ptr_ptr = a_callback_void_ptr_ptr;
	callback_void_general = a_callback_void_general;
}
