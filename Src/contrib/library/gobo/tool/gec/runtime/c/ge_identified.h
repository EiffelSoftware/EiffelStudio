/*
	description:

		"C functions used to implement class IDENTIFIED"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_IDENTIFIED_H
#define GE_IDENTIFIED_H

#ifdef __cplusplus
extern "C" {
#endif

/*
	Get a new id for `object', assuming it is NOT in the stack.
*/
extern EIF_INTEGER GE_object_id(EIF_OBJECT object);

/*
	Return the object associated with `id'.
*/
extern EIF_REFERENCE GE_id_object(EIF_INTEGER id);

/*
	Remove the object associated with `id' from the stack.
*/
extern void GE_object_id_free(EIF_INTEGER id);

#ifdef __cplusplus
}
#endif

#endif
