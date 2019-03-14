/*
	description:

		"C functions used to implement class STORABLE"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_RETRIEVE_C
#define EIF_RETRIEVE_C
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifndef EIF_RETRIEVE_H
#include "eif_retrieve.h"
#endif
#ifndef GE_CONSOLE_H
#include "ge_console.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

char* eretrieve(EIF_INTEGER file_desc)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'eretrieve' in 'eif_retrieve.h' not implemented\n");
	return (char*)0;
}

void eif_set_discard_pointer_values(EIF_BOOLEAN state)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'eif_set_discard_pointer_values' in 'eif_retrieve.h' not implemented\n");
}

EIF_REFERENCE stream_eretrieve(EIF_POINTER* buffer, EIF_INTEGER size, EIF_INTEGER start_pos, EIF_INTEGER* real_size)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'stream_eretrieve' in 'eif_retrieve.h' not implemented\n");
	return EIF_VOID;
}

void set_mismatch_information_access(EIF_OBJECT object, EIF_PROCEDURE init, EIF_PROCEDURE add, EIF_PROCEDURE set_vers)
{
	/* TODO */
}

void class_translation_put (char* new_name, char* old_name)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'class_translation_put' in 'eif_retrieve.h' not implemented\n");
}

void class_translation_clear (void)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'class_translation_clear' in 'eif_retrieve.h' not implemented\n");
}

EIF_INTEGER class_translation_count (void)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'class_translation_count' in 'eif_retrieve.h' not implemented\n");
	return (EIF_INTEGER)0;
}

char* class_translation_old (EIF_INTEGER i)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'class_translation_old' in 'eif_retrieve.h' not implemented\n");
	return (char*)0;
}

char* class_translation_new (EIF_INTEGER i)
{
	/* TODO */
	GE_show_console();
	fprintf(stderr, "'class_translation_new' in 'eif_retrieve.h' not implemented\n");
	return (char*)0;
}

#ifdef __cplusplus
}
#endif

#endif
