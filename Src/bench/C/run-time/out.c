/*

  ####   #    #   #####           ####
 #    #  #    #     #            #    #
 #    #  #    #     #            #
 #    #  #    #     #     ###    #
 #    #  #    #     #     ###    #    #
  ####    ####      #     ###     ####

		Routines for printing an Eiffel object.
*/

#include "config.h"
#include "out.h"
#include "plug.h"
#include "eiffel.h"
#include "struct.h"
#include "macros.h"		/* For macro LNGPAD */
#include "hashin.h"
#include "except.h"		/* For `eraise' */
#include "sig.h"
#include "hector.h"
#include "bits.h"
#include <stdio.h>

/*
 * Private declarations
 */

#define TAG_SIZE 512		/* Maximum size for a single tagged expression */

rt_private char buffer[TAG_SIZE];/* Buffer for printing an object in a string */
rt_private char *tagged_out;		/* String where the tagged out is written */
rt_private int tagged_max;			/* Actual maximum size of `tagged_out' */
rt_private int tagged_len;			/* Actual length of `tagged_out' */

rt_private void write_string(char *str);	/* Write a string in `tagged_out' */
rt_private void write_char(EIF_CHARACTER c, char *buf);		/* Write a character */
rt_private void write_out(void);		/* Write in `tagged_out' */
rt_private void write_tab(register int tab);		/* Print tabulations */
rt_private void rec_write(register char *object, int tab);		/* Write object print in `tagged_out' */
rt_private void rec_swrite(register char *object, int tab);		/* Write special object */
rt_private void buffer_allocate(void);	/* Allocate initial buffer */
rt_shared char *build_out(EIF_OBJ object);		/* Build `tagged_out' string */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/*
 * Routine for printing representation
 */

rt_public char *c_generator(register char *Current)
{
	/* Class name from which the Eiffel object is an instance.
	 * Return a reference on an Eiffel instance of STRING.
	 */

	register2 uint32 flags = HEADER(Current)->ov_flags; /* Object flags */
	char *generator;

	if (flags & EO_SPEC)
		return makestr("SPECIAL", 7);
	
	generator = System(flags & EO_TYPE).cn_generator;

	return makestr(generator, strlen(generator));
}

rt_public char *c_tagged_out(EIF_OBJ object)
{
	/* Write a tagged out printing in an string.
	 * Return a pointer on an Eiffel string object.
	 */

	char *result;		/* The Eiffel string returned */

	build_out(object);	/* Build tagged out string for object */
	result = makestr(tagged_out, strlen(tagged_out));
	xfree(tagged_out);	/* Buffer not needed anymore */

	return result;		/* An Eiffel string */
}

rt_public char *build_out(EIF_OBJ object)
{
	/* Build up tagged out representation in a private global buffer */

	uint32 flags;		/* Object flags */

	buffer_allocate();	/* Allocation of `tagged_out' */

	flags = HEADER(eif_access(object))->ov_flags;

	if (flags & EO_SPEC) {
		/* Special object */
		sprintf(buffer, "SPECIAL [0x%lX]\n", eif_access(object));
		write_out();
		/* Print recursively in `tagged_out' */
		rec_swrite(eif_access(object), 0);
	} else {
		/* Print instance class name and object id */
		sprintf(buffer, "%s [0x%lX]\n", System(flags & EO_TYPE).cn_generator,
			eif_access(object));
		write_out();
		/* Print recursively in `tagged_out' */
		rec_write(eif_access(object), 0);
	}

	*buffer = '\0';
	write_out();

	return tagged_out;		/* This arena must be freed manually */
}

rt_private void buffer_allocate(void)
{
	/* Allocates initial tagged out buffer */

	tagged_out = (char *) xcalloc(TAG_SIZE, sizeof(char));
	if (tagged_out == (char *) 0)
		enomem(MTC_NOARG);
	tagged_max = TAG_SIZE;
	tagged_len = 0;
}

rt_private void rec_write(register char *object, int tab)
{
	/* Print recursively `object' in `tagged_out' */

	register2 struct cnode *obj_desc;	   /* Object type description */
	register3 long nb_attr;				 /* Attribute number */
	register4 uint32 *types;                /* Attribute types */
#ifndef WORKBENCH
	register6 long **offsets;			   /* Attribute offsets table */
#else
	register4 int32 *cn_attr;			   /* Attribute keys */
	long offset;
#endif
	register5 int16 dyn_type;			   /* Object dynamic type */
	char *o_ref;
	register7 char **names;				 /* Attribute names */
	char *reference;						/* Reference attribute */
	/* char *refptr;*/ /* %%ss removed */
	/* union overhead *zone;*/ /* %%ss removed */
	long i; /* %%ss removed , nb_old, nb_reference; */
	uint32 type, ref_flags;

	dyn_type = Dtype(object);
	obj_desc = &System(dyn_type);
	nb_attr = obj_desc->cn_nbattr;
	names = obj_desc->cn_names;
	types = obj_desc->cn_types;

#ifndef WORKBENCH
	offsets = obj_desc->cn_offsets;
#else
	cn_attr = obj_desc->cn_attr;
#endif

	/* Print attributes */
	for (i = 0; i < nb_attr; i++) {

		/* Print attribute name */
		write_tab(tab+1);
		sprintf(buffer, "%s: ", names[i]);
		write_out();

		/* Print attribute value */
		type = types[i];
#ifndef WORKBENCH
		o_ref = object + (offsets[i])[dyn_type];
#else
		CAttrOffs(offset,cn_attr[i],dyn_type);
		o_ref = object + offset;
#endif
		switch(type & SK_HEAD) {
		case SK_POINTER:
			/* Pointer attribute */
			sprintf(buffer, "POINTER =  C pointer 0x%lX\n", *(fnptr *)o_ref);
			write_out();
			break;
		case SK_BOOL:
			/* Boolean attribute */
			sprintf(buffer, "BOOLEAN = ");
			write_out();
			if (*o_ref)
				sprintf(buffer, "True\n");
			else
				sprintf(buffer, "False\n");
			write_out();
			break;
		case SK_CHAR:
			/* Character attribute */
			write_char(*o_ref, buffer);
			write_out();
			break;
		case SK_INT:
			/* Integer attribute */
			sprintf(buffer, "INTEGER = %ld\n", *(long *)o_ref);
			write_out();
			break;
		case SK_FLOAT:
			/* Real attribute */
			sprintf(buffer, "REAL = %g\n", *(float *)o_ref);
			write_out();
			break;
		case SK_DOUBLE:
			/* Double attribute */
			sprintf(buffer, "DOUBLE = %.17g\n", *(double *)o_ref);
			write_out();
			break;	
		case SK_BIT:
			{		
				char *str = b_out(o_ref);

				sprintf(buffer, "BIT %ld = ", LENGTH(o_ref));
				write_out();
				write_string(str);
				sprintf(buffer, "\n");
				write_out();
				xfree(str);	/* Allocated by `b_out' */
			}
			break;
		case SK_EXP:
			/* Expanded attribute */
			sprintf(buffer, "expanded %s\n", System(Dtype(o_ref)).cn_generator);
			write_out();
			write_tab (tab + 2);
			sprintf(buffer, "-- begin sub-object --\n");
			write_out();

			rec_write((char *)o_ref, tab + 3);

			write_tab(tab + 2);
			sprintf(buffer, "-- end sub-object --\n");
			write_out();
			break;
		default: 
			/* Object reference */
			reference = *(char **)o_ref;
			if (0 != reference) {
				ref_flags = HEADER(reference)->ov_flags;
				if (ref_flags & EO_C) {
					/* C reference */
					sprintf(buffer, "POINTER = C pointer 0x%lX\n", reference);
					write_out();
				} else if (ref_flags & EO_SPEC) {
					/* Special object */
					sprintf(buffer, "SPECIAL [0x%lX]\n", reference);
					write_out();
					write_tab(tab + 2);
					sprintf(buffer, "-- begin special object --\n");
					write_out();

					rec_swrite(reference, tab + 3);

					write_tab(tab + 2);
					sprintf(buffer, "-- end special object --\n");
					write_out();
				} else {
					sprintf(buffer, "%s [0x%lX]\n",
						System(Dtype(reference)).cn_generator, reference);
					write_out();
				}
			} else {
				sprintf(buffer, "Void\n");
				write_out();
			}
		}
	}
}

rt_private void rec_swrite(register char *object, int tab)
{
	/* Print special object */

	union overhead *zone;		/* Object header */
	register5 uint32 flags;		/* Object flags */
	register3 long count;		/* Element count */
	register4 long elem_size;	/* Element size */
	char *o_ref;
	char *reference; /* %%ss removed , *bit; */
	long old_count;
	int dt_type;

	zone = HEADER(object);
	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
	count = *(long *) o_ref;
	old_count = count;
	elem_size = *(long *) (o_ref + sizeof(long));
	flags = zone->ov_flags;
	dt_type = (int) (flags & EO_TYPE);

	if (!(flags & EO_REF)) 
		if (flags & EO_COMP) 
			for (o_ref = object + OVERHEAD; count > 0; count--,
						o_ref += elem_size) {
				write_tab(tab + 1);
				sprintf(buffer, "%ld: expanded ", old_count - count);
				write_out();
				sprintf(buffer, "%s\n", System(Dtype(o_ref)).cn_generator);
				write_out();
				write_tab(tab + 2);
				sprintf(buffer, "-- begin sub-object --\n");
				write_out();
		
				rec_write(o_ref, tab + 3);
	
				write_tab(tab + 2);
				sprintf(buffer, "-- end sub-object --\n");
				write_out();
			}
		else
			for (o_ref = object; count > 0; count--,
						o_ref += elem_size) {
				write_tab(tab + 1);
				sprintf(buffer, "%ld: ", old_count - count);
				write_out();
				if (dt_type == sp_char) {
					write_char(*o_ref, buffer);
					write_out();
				} else if (dt_type == sp_int) {
					sprintf(buffer, "INTEGER = %ld\n", *(long *)o_ref);
					write_out();
				} else if (dt_type == sp_bool) {
					sprintf(buffer, "BOOLEAN = %s\n", (*o_ref ? "True" : "False"));
					write_out();
				} else if (dt_type == sp_real) {
					sprintf(buffer, "REAL = %g\n", *(float *)o_ref);
					write_out();
				} else if (dt_type == sp_double) {
					sprintf(buffer, "DOUBLE = %.17g\n", *(double *)o_ref);
					write_out();
				} else if (dt_type == sp_pointer) {
					sprintf(buffer, "POINTER = C pointer 0x%lX\n", *(fnptr *)o_ref);
					write_out();
				} else {
					/* Must be bit */
					char *str = b_out(o_ref);

					sprintf(buffer, "BIT %ld = ", LENGTH(o_ref));
					write_out();
					write_string(str);
					sprintf(buffer, "\n");
					write_out();
					xfree(str);	/* Allocated by `b_out' */
				}
			}
	else 
		for (o_ref = object; count > 0; count--,
					o_ref = (char *) ((char **)o_ref + 1)) {
			write_tab(tab + 1);
			sprintf(buffer, "%ld: ", old_count - count);
			write_out();
			reference = *(char **)o_ref;
			if (0 == reference)
				sprintf(buffer, "Void\n");
			else if (HEADER(reference)->ov_flags & EO_C)
				sprintf(buffer, "POINTER = C pointer 0x%lX\n", reference);
			else
				sprintf(buffer, "%s [0x%lX]\n",
					System(Dtype(reference)).cn_generator, reference);
			write_out();
		}
}

rt_private void write_tab(register int tab)
{
	register1 int i = 0;

	for (; i < tab; i++) {
		sprintf(buffer,"  ");
		write_out();
	}
}

rt_private void write_char (EIF_CHARACTER c, char *buf)
                			/* The character */
          		/* Where it should be written */
{
	/* Write a character in `buffer' */
		
	if (c < ' ')
		sprintf(buf, "CHARACTER = Ctrl-%c\n", c + '@');
	else if (c > 127) {
		c -= 128;
		if (c < ' ')
			sprintf(buf, "CHARACTER = Ext-Ctrl-%c\n", c + '@');
		else
			sprintf(buf, "CHARACTER = Ext-%c\n", c);
	} else
		sprintf(buf, "CHARACTER = '%c'\n", c);
}

rt_private void write_out(void)
{
	/* Print private string `buffer' in `tagged_out'. */

	write_string(buffer);
}

rt_private void write_string(char *str)
{
	/* Print `str' in `tagged_out'. */

	int buffer_len = strlen(str);	/* Length of `str' */

	tagged_len += buffer_len;
	if (tagged_len >= tagged_max) {
		/* Reallocation of C string `tagged_out' */
		do 
			tagged_max *= 2;
		while (tagged_len >= tagged_max);
		tagged_out = xrealloc(tagged_out, tagged_max, GC_OFF);
		if (tagged_out == (char *) 0)
			enomem(MTC_NOARG);
	}
	/* Append `str' to `tagged_out' */
	strcat(tagged_out, str);
}

/*
 * Building `out' representation for various data types.
 */

rt_public char *c_outb(EIF_BOOLEAN b)
{
	if (b)
		return makestr("true", 4);
	else
		return makestr("false", 5);
}

rt_public char *c_outi(EIF_INTEGER i)
{
	sprintf(buffer, "%ld", i);
	return makestr(buffer, strlen(buffer));
}

rt_public char *c_outr(EIF_REAL f)
{
	sprintf(buffer, "%g", f);
	return makestr(buffer, strlen(buffer));
}

rt_public char *c_outd(EIF_DOUBLE d)
{
	sprintf(buffer, "%.17g", d);
	return makestr(buffer, strlen(buffer));
}

rt_public char *c_outc(EIF_CHARACTER c)
{
	buffer[0] = c;
	buffer[1] = '\0';
	return makestr(buffer, 1);
}

rt_public char *c_outp(EIF_POINTER p)
{
	sprintf(buffer, "0x%lX", p);
	return makestr(buffer, strlen(buffer));
}

#ifdef WORKBENCH

#include "interp.h"

/* The following routine builds a tagged out string out of simple types.
 * The reason for this is that the debugger can request the value of, say,
 * local #2, and this might be an integer for instance... We cannot call
 * build_out, as it expects a true object, not a simple type...
 */

rt_shared char *simple_out(struct item *val) 
                 			/* Interpreter value cell */
{
	/* Hand build a tagged out representation for simple types. The
	 * representation should be kept in sync with those defined above.
	 * NB: this whole file needs a clean rewriting--RAM.
	 */

	buffer_allocate();		/* Allocate initial `tagged_out' buffer */

	switch (val->type & SK_HEAD) {
	case SK_EXP:
	case SK_REF:
		xfree(tagged_out);					/* What a waste of CPU cycles */
		return build_out((EIF_OBJ)(&val->it_ref));		/* Only for the beauty of it */
	case SK_VOID:
		sprintf(tagged_out, "Not an object!");
		break;
	case SK_BOOL:
		sprintf(tagged_out, "BOOLEAN = %s", val->it_char ? "True" : "False");
		break;
	case SK_CHAR:
		write_char(val->it_char, tagged_out);
		break;
	case SK_INT:
		sprintf(tagged_out, "INTEGER = %ld", val->it_long);
		break;
	case SK_FLOAT:
		sprintf(tagged_out, "REAL = %g", val->it_float);
		break;
	case SK_DOUBLE:
		sprintf(tagged_out, "DOUBLE = %.17g", val->it_double);
	case SK_BIT:
		sprintf(tagged_out, "Bit object");
		break;
	case SK_POINTER:
		sprintf(tagged_out, "POINTER = C pointer 0x%lX", val->it_ref);
		break;
	default:
		sprintf(tagged_out, "Not an object?");
		break;
	}

	return tagged_out;
}

#endif

