/*
	description: "Routines for printing an Eiffel object."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="out.c" header="eif_out.h" version="$Id$" summary="Routines for printing Eiffel objects">
*/

#include "eif_portable.h"
#include "eif_project.h"
#include "eif_eiffel.h"
#include "rt_out.h"
#include "eif_helpers.h"
#include "eif_plug.h"
#include "rt_struct.h"
#include "rt_hashin.h"
#include "eif_except.h"		/* For `eraise' */
#include "eif_sig.h"
#include "eif_hector.h"
#include "rt_bits.h"
#include "eif_globals.h"
#include "rt_malloc.h"
#include "rt_wbench.h"
#include "rt_macros.h"
#include "rt_constants.h"
#include "rt_gen_types.h"
#include "rt_assert.h"
#include <string.h>
#include <stdio.h>

/*
 * Private declarations
 */

#ifndef EIF_THREADS
/*
doc:	<attribute name="buffero" return_type="char [TAG_SIZE]" export="shared">
doc:		<summary>Buffer for printing an object in a string.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_shared char buffero[TAG_SIZE];

/*
doc:	<attribute name="tagged_out" return_type="char *" export="private">
doc:		<summary>String where the tagged out is written.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private char *tagged_out = NULL;

/*
doc:	<attribute name="tagged_max" return_type="size_t" export="private">
doc:		<summary>Actual maximum size of `tagged_out'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private size_t tagged_max = 0;

/*
doc:	<attribute name="tagged_len" return_type="size_t" export="private">
doc:		<summary>Actual length of `tagged_out'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data.</synchronization>
doc:	</attribute>
*/
rt_private size_t tagged_len = 0;
#endif /* EIF_THREADS */

rt_private void write_string(char *str);	/* Write a string in `tagged_out' */
rt_private void write_char(EIF_CHARACTER c);		/* Write a character */
rt_private void write_attribute_character(EIF_CHARACTER c);		/* Write a character as an Eiffel attribute */
rt_private void write_tab(register int tab);		/* Print tabulations */
rt_private void rec_write(register EIF_REFERENCE object, int tab);	/* Write object print in `tagged_out' */
rt_private void rec_swrite(register EIF_REFERENCE object, int tab);		/* Write special object */
rt_private void rec_twrite(register EIF_REFERENCE object, int tab);		/* Write tuple object */
rt_private void buffer_allocate(void);	/* Allocate initial buffer */
rt_public char *eif_out(EIF_REFERENCE object);		/* Build a copy of "tagged_out" for CECIL programmer. */
rt_shared char *build_out(EIF_REFERENCE object);		/* Build `tagged_out' string */


/*
 * Routine for printing representation
 */

rt_public EIF_REFERENCE c_generator_of_type (EIF_INTEGER dftype)
	/* Class name associated with dynamic type `dftype'.
	 * Return a reference on an Eiffel instance of STRING.
	 */
{
	char *generator;
	generator = System (To_dtype(dftype)).cn_generator;
	return makestr (generator, strlen (generator));
}

rt_public EIF_REFERENCE c_tagged_out(EIF_REFERENCE object)
{
	/* Write a tagged out printing in an string.
	 * Return a pointer on an Eiffel string object.
	 */
	RT_GET_CONTEXT
	EIF_REFERENCE result;		/* The Eiffel string returned */

	tagged_out = build_out(object);	/* Build tagged out string for object */
	result = makestr(tagged_out, strlen(tagged_out));
	eif_rt_xfree(tagged_out);	/* Buffer not needed anymore */

	return result;		/* An Eiffel string */
}

rt_public char *eif_out (EIF_REFERENCE object) 
{
	/* Like "build_out" but for CECIL programmer. */
	return build_out (object);	/* Build "tagged_out".*/
}	/* eif_out */

	

rt_shared char *build_out(EIF_REFERENCE object)
{
	/* Build up tagged out representation in a private global buffer */
	RT_GET_CONTEXT
	uint16 flags;		/* Object flags */

	buffer_allocate();	/* Allocation of `tagged_out' */

	flags = HEADER(object)->ov_flags;

		/* Print instance type name */
	write_string (eif_typename(Dftype(object)));
	sprintf(buffero, " [0x%" EIF_POINTER_DISPLAY "]\n", (rt_uint_ptr) object);
	write_string(buffero);
		/* Print recursively in `tagged_out' */
	if (flags & EO_SPEC) {
		if (flags & EO_TUPLE) {
			rec_twrite(object, 0);
		} else {
			rec_swrite(object, 0);
		}
	} else {
		rec_write(object, 0);
	}
	write_char ('\0');

	return tagged_out;		/* This arena must be freed manually */
}

rt_private void buffer_allocate(EIF_CONTEXT_NOARG)
{
	RT_GET_CONTEXT
	/* Allocates initial tagged out buffer */

	tagged_out = (char *) eif_rt_xcalloc(TAG_SIZE, sizeof(char));
	if (tagged_out == (char *) 0)
		enomem(MTC_NOARG);
	tagged_max = TAG_SIZE;
	tagged_len = 0;
}

rt_private void rec_write(register EIF_REFERENCE object, int tab)
{
	/* Print recursively `object' in `tagged_out' */
	RT_GET_CONTEXT
	struct cnode *obj_desc;	   /* Object type description */
	long nb_attr;				 /* Attribute number */
	uint32 *types;                /* Attribute types */
#ifndef WORKBENCH
	long *offsets;			   /* Attribute offsets table */
#else
	int32 *cn_attr;			   /* Attribute keys */
	long offset;
#endif
	EIF_TYPE_INDEX dyn_type;			   /* Object dynamic type */
	EIF_REFERENCE o_ref;
	char **names;				 /* Attribute names */
	EIF_REFERENCE reference;						/* Reference attribute */
	long i;
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
		write_string (names [i]);
		write_string (": ");

		/* Print attribute value */
		type = types[i];
#ifndef WORKBENCH
		o_ref = object + offsets[i];
#else
		CAttrOffs(offset,cn_attr[i],dyn_type);
		o_ref = object + offset;
#endif
		switch(type & SK_HEAD) {
		case SK_POINTER:
			/* Pointer attribute */
			sprintf(buffero, "POINTER =  C pointer 0x%" EIF_POINTER_DISPLAY "\n", (rt_uint_ptr) (*(fnptr *)o_ref));
			write_string(buffero);
			break;
		case SK_BOOL:
			/* Boolean attribute */
			write_string("BOOLEAN = ");
			if (*o_ref) {
				write_string ("True\n");
			} else {
				write_string ("False\n");
			}
			break;
		case SK_CHAR:
			/* Character attribute */
			write_attribute_character (*o_ref);
			break;
		case SK_WCHAR:
			/* Wide character attribute */
			sprintf(buffero, "WIDE_CHARACTER = U+%x\n", *(EIF_WIDE_CHAR *)o_ref);
			write_string(buffero);
			break;
		case SK_UINT8:
			/* Natural 8 bits attribute */
			sprintf(buffero, "NATURAL_8 = %u\n", *(EIF_NATURAL_8 *)o_ref);
			write_string(buffero);
			break;
		case SK_UINT16:
			/* Natural 16 bits attribute */
			sprintf(buffero, "NATURAL_16 = %u\n", *(EIF_NATURAL_16 *)o_ref);
			write_string(buffero);
			break;
		case SK_UINT32:
			/* Natural 32 bits attribute */
			sprintf(buffero, "NATURAL_32 = %u\n", *(EIF_NATURAL_32 *)o_ref);
			write_string(buffero);
			break;
		case SK_UINT64:
			/* Natural 64 bits attribute */
			sprintf(buffero, "NATURAL_64 = %" EIF_NATURAL_64_DISPLAY "\n", *(EIF_NATURAL_64 *) o_ref);
			write_string(buffero);
			break;
		case SK_INT8:
			/* Integer 8 bits attribute */
			sprintf(buffero, "INTEGER_8 = %d\n", *(EIF_INTEGER_8 *)o_ref);
			write_string(buffero);
			break;
		case SK_INT16:
			/* Integer 16 bits attribute */
			sprintf(buffero, "INTEGER_16 = %d\n", *(EIF_INTEGER_16 *)o_ref);
			write_string(buffero);
			break;
		case SK_INT32:
			/* Integer 32 bits attribute */
			sprintf(buffero, "INTEGER_32 = %d\n", *(EIF_INTEGER_32 *)o_ref);
			write_string(buffero);
			break;
		case SK_INT64:
			/* Integer 64 bits attribute */
			sprintf(buffero, "INTEGER_64 = %" EIF_INTEGER_64_DISPLAY "\n",
				 *(EIF_INTEGER_64 *) o_ref);
			write_string(buffero);
			break;
		case SK_REAL32:
			/* Real attribute */
			write_string("REAL_32 = ");
			c_buffero_outr32(*(EIF_REAL_32 *) o_ref);
			write_string(buffero);
			write_string("\n");
			break;
		case SK_REAL64:
			/* Double attribute */
			write_string("REAL_64 = ");
			c_buffero_outr64(*(EIF_REAL_64 *) o_ref);
			write_string(buffero);
			write_string("\n");
			break;	
		case SK_BIT:
			{		
				char *str = b_out(o_ref);

				sprintf(buffero, "BIT %u = ", LENGTH(o_ref));
				write_string(buffero);
				write_string(str);
				sprintf(buffero, "\n");
				write_string(buffero);
				eif_rt_xfree(str);	/* Allocated by `b_out' */
			}
			break;
		case SK_EXP:
			/* Expanded attribute */
			write_string("expanded ");
			write_string(eif_typename(Dftype(o_ref)));
			write_char ('\n');
			write_tab (tab + 2);
			sprintf(buffero, "-- begin sub-object --\n");
			write_string(buffero);

			rec_write((EIF_REFERENCE)o_ref, tab + 3);

			write_tab(tab + 2);
			sprintf(buffero, "-- end sub-object --\n");
			write_string(buffero);
			break;
		default: 
			/* Object reference */
			reference = *(EIF_REFERENCE *)o_ref;
			if (reference) {
				ref_flags = HEADER(reference)->ov_flags;
				write_string(eif_typename(Dftype(reference)));
				sprintf(buffero, " [0x%" EIF_POINTER_DISPLAY "]\n", (rt_uint_ptr) reference);
				write_string(buffero);
				if (ref_flags & EO_SPEC) {
					if (ref_flags & EO_TUPLE) {
						write_tab(tab + 2);
						sprintf(buffero, "-- begin tuple object --\n");
						write_string(buffero);

						rec_twrite(reference, tab + 3);

						write_tab(tab + 2);
						sprintf(buffero, "-- end tuple object --\n");
						write_string(buffero);

					} else {
						write_tab(tab + 2);
						sprintf(buffero, "-- begin special object --\n");
						write_string(buffero);

						rec_swrite(reference, tab + 3);

						write_tab(tab + 2);
						sprintf(buffero, "-- end special object --\n");
						write_string(buffero);
					}
				}
			} else {
				sprintf(buffero, "Void\n");
				write_string(buffero);
			}
		}
	}
}

rt_private void rec_swrite(register EIF_REFERENCE object, int tab)
{
	/* Print special object */
	RT_GET_CONTEXT
	union overhead *zone;		/* Object header */
	uint16 flags;		/* Object flags */
	EIF_INTEGER count;		/* Element count */
	rt_uint_ptr elem_size;	/* Element size */
	EIF_REFERENCE o_ref;
	EIF_REFERENCE reference;
	EIF_INTEGER old_count;
	EIF_TYPE_INDEX dtype;

	zone = HEADER(object);
	old_count = count = RT_SPECIAL_COUNT(object);
	elem_size = RT_SPECIAL_ELEM_SIZE(object);
	flags = zone->ov_flags;
	dtype = zone->ov_dtype;

	if (!(flags & EO_REF)) 
		if (flags & EO_COMP) 
			for (o_ref = object + OVERHEAD; count > 0; count--,
						o_ref += elem_size) {
				write_tab(tab + 1);
				sprintf(buffero, "%ld: expanded ", (long) (old_count - count));
				write_string(buffero);
				write_string(eif_typename(Dftype(o_ref)));
				write_char('\n');
				write_tab(tab + 2);
				sprintf(buffero, "-- begin sub-object --\n");
				write_string(buffero);
		
				rec_write(o_ref, tab + 3);
	
				write_tab(tab + 2);
				sprintf(buffero, "-- end sub-object --\n");
				write_string(buffero);
			}
		else
			for (o_ref = object; count > 0; count--,
						o_ref += elem_size) {
				write_tab(tab + 1);
				sprintf(buffero, "%ld: ", (long) (old_count - count));
				write_string(buffero);
				if (dtype == egc_sp_char) {
					write_attribute_character (*o_ref);
				} else if (dtype == egc_sp_wchar) {
					sprintf(buffero, "WIDE_CHARACTER = U+%x\n", *(EIF_WIDE_CHAR *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_uint8) {
					sprintf(buffero, "NATURAL_8 = %u\n", *(EIF_NATURAL_8 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_uint16) {
					sprintf(buffero, "NATURAL_16 = %u\n", *(EIF_NATURAL_16 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_uint32) {
					sprintf(buffero, "NATURAL_32 = %u\n", *(EIF_NATURAL_32 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_uint64) {
					sprintf(buffero, "NATURAL_64 = %" EIF_NATURAL_64_DISPLAY "\n", *(EIF_NATURAL_64 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_int8) {
					sprintf(buffero, "INTEGER_8 = %d\n", *(EIF_INTEGER_8 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_int16) {
					sprintf(buffero, "INTEGER_16 = %d\n", *(EIF_INTEGER_16 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_int32) {
					sprintf(buffero, "INTEGER_32 = %d\n", *(EIF_INTEGER_32 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_int64) {
					sprintf(buffero, "INTEGER_64 = %" EIF_INTEGER_64_DISPLAY "\n",
						*(EIF_INTEGER_64 *)o_ref);
					write_string(buffero);
				} else if (dtype == egc_sp_bool) {
					write_string ("BOOLEAN = ");
					if (*o_ref) {
						write_string ("True");
					} else {
						write_string ("False");
					}
					write_char('\n');
				} else if (dtype == egc_sp_real32) {
					write_string("REAL_32 = ");
					c_buffero_outr32(*(EIF_REAL_32 *) o_ref);
					write_string(buffero);
					write_string("\n");
				} else if (dtype == egc_sp_real64) {
					write_string("REAL_64 = ");
					c_buffero_outr64(*(EIF_REAL_64 *) o_ref);
					write_string(buffero);
					write_string("\n");
				} else if (dtype == egc_sp_pointer) {
					sprintf(buffero, "POINTER = C pointer 0x%" EIF_POINTER_DISPLAY "\n",
						(rt_uint_ptr) (*(fnptr *)o_ref));
					write_string(buffero);
				} else {
					/* Must be bit */
					char *str = b_out(o_ref);

					sprintf(buffero, "BIT %u = ", LENGTH(o_ref));
					write_string(buffero);
					write_string(str);
					sprintf(buffero, "\n");
					write_string(buffero);
					eif_rt_xfree(str);	/* Allocated by `b_out' */
				}
			}
	else 
		for (o_ref = object; count > 0; count--,
					o_ref = (EIF_REFERENCE) ((EIF_REFERENCE *)o_ref + 1)) {
			write_tab(tab + 1);
			sprintf(buffero, "%ld: ", (long) (old_count - count));
			write_string(buffero);
			reference = *(EIF_REFERENCE *) o_ref;
			if (!reference) {
				sprintf(buffero, "Void\n");
			} else {
				write_string (eif_typename(Dftype(reference)));
				sprintf(buffero, " [0x%" EIF_POINTER_DISPLAY "]\n", (rt_uint_ptr) reference);
			}
			write_string(buffero);
		}
}

rt_private void rec_twrite(register EIF_REFERENCE object, int tab)
	/* Print tuple object */
{
	RT_GET_CONTEXT
	unsigned int count = RT_SPECIAL_COUNT (object);
	unsigned int i = 1;
	EIF_TYPE_INDEX dftype = Dftype (object);

	REQUIRE("Is tuple", HEADER(object)->ov_flags & EO_TUPLE);

		/* Don't forget that first element of TUPLE is the BOOLEAN
		 * `object_comparison' attribute which we don't print here. */
	for (; i < count; i++) {
		write_tab(tab + 1);
		sprintf(buffero, "%ld: ", (long) i);
		write_string(buffero);
		switch (eif_gen_typecode_with_dftype(dftype, i)) {
			case EIF_BOOLEAN_CODE:
				write_string ("BOOLEAN = ");
				if (eif_boolean_item(object, i)) {
					write_string ("True");
				} else {
					write_string ("False");
				}
				write_char('\n');
				break;
			case EIF_CHARACTER_CODE:
				write_attribute_character (eif_character_item(object,i));
				break;
			case EIF_REAL_64_CODE:
				write_string("REAL_64 = ");
				c_buffero_outr64(eif_real_64_item(object,i));
				write_string(buffero);
				write_string("\n");
				break;
			case EIF_REAL_32_CODE:
				write_string("REAL_32 = ");
				c_buffero_outr32(eif_real_32_item(object,i));
				write_string(buffero);
				write_string("\n");
				break;
			case EIF_POINTER_CODE:
				sprintf(buffero, "POINTER = 0x%" EIF_POINTER_DISPLAY "\n", (rt_uint_ptr) eif_pointer_item(object,i));
				write_string(buffero);
				break;
			case EIF_REFERENCE_CODE:
				if (eif_reference_item(object,i) == NULL) {
					sprintf(buffero, "Void\n");
					write_string(buffero);
				} else {
					write_string(eif_typename(Dftype(eif_reference_item(object, i))));
					sprintf(buffero, " [0x%" EIF_POINTER_DISPLAY "]\n", (rt_uint_ptr) eif_reference_item(object,i));
					write_string(buffero);
				}
				break;
			case EIF_NATURAL_8_CODE:
				sprintf(buffero, "NATURAL_8 = %u\n", eif_natural_8_item(object,i));
				write_string(buffero);
				break;
			case EIF_NATURAL_16_CODE:
				sprintf(buffero, "NATURAL_16 = %u\n", eif_natural_16_item(object,i));
				write_string(buffero);
				break;
			case EIF_NATURAL_32_CODE:
				sprintf(buffero, "NATURAL_32 = %u\n", eif_natural_32_item(object,i));
				write_string(buffero);
				break;
			case EIF_NATURAL_64_CODE:
				sprintf(buffero, "NATURAL_64 = %" EIF_NATURAL_64_DISPLAY "\n",
					eif_natural_64_item(object,i));
				write_string(buffero);
				break;
			case EIF_INTEGER_8_CODE:
				sprintf(buffero, "INTEGER_8 = %d\n", eif_integer_8_item(object,i));
				write_string(buffero);
				break;
			case EIF_INTEGER_16_CODE:
				sprintf(buffero, "INTEGER_16 = %d\n", eif_integer_16_item(object,i));
				write_string(buffero);
				break;
			case EIF_INTEGER_32_CODE:
				sprintf(buffero, "INTEGER_32 = %d\n", eif_integer_32_item(object,i));
				write_string(buffero);
				break;
			case EIF_INTEGER_64_CODE:
				sprintf(buffero, "INTEGER_64 = %" EIF_INTEGER_64_DISPLAY "\n",
					eif_integer_64_item(object,i));
				write_string(buffero);
				break;
			case EIF_WIDE_CHAR_CODE:
				sprintf(buffero, "WIDE_CHARACTER = U+%x\n", eif_wide_character_item(object,i));
				write_string(buffero);
				break;
		}
	}
}

rt_private void write_char(EIF_CHARACTER c)
{
		/* Print `c' in `tagged_out'. */
	RT_GET_CONTEXT
	tagged_len += sizeof(EIF_CHARACTER);
	if (tagged_len >= tagged_max) {
		/* Reallocation of C string `tagged_out' */
		do 
			tagged_max *= 2;
		while (tagged_len >= tagged_max);
		tagged_out = (char *) xrealloc(tagged_out, tagged_max, GC_OFF);
		if (tagged_out == (char *) 0)
			enomem(MTC_NOARG);
	}
		/* Append `str' to `tagged_out' */
	tagged_out[tagged_len - 1] = c;
}

rt_private void write_tab(register int tab)
{
	int i = 0;

	for (; i < tab; i++) {
		write_char (' ');
		write_char (' ');
	}
}

rt_private void write_attribute_character (EIF_CHARACTER c)
							/* The character */
		  		/* Where it should be written */
{
		/* Write a character in `buffer' */
	write_string ("CHARACTER = ");
	if (c < ' ') {
		write_string ("Ctrl-");
		write_char (c + '@');
	} else if (c > 127) {
		c -= 128;
		write_string ("Ext-Ctrl-");
		if (c < ' ') {
			write_char (c + '@');
		} else {
			write_char (c);
		}
	} else {
		write_char ('\'');
		write_char (c);
		write_char ('\'');
	}
	write_char ('\n');
}

rt_private void write_string(char *str)
{
	/* Print `str' in `tagged_out'. */
	RT_GET_CONTEXT
	size_t buffer_len = strlen(str);	/* Length of `str' */
	size_t j, i = tagged_len;

	tagged_len += buffer_len;
	if (tagged_len >= tagged_max) {
			/* Reallocation of C string `tagged_out' */
		do {
			tagged_max *= 2;
		} while (tagged_len >= tagged_max);

		tagged_out = (char *) xrealloc(tagged_out, tagged_max, GC_OFF);
		if (tagged_out == (char *) 0) {
			enomem(MTC_NOARG);
		}
	}
		/* Append `str' to `tagged_out' */
	for (j = 0; i < tagged_len; i++, j++) {
		tagged_out[i] = str[j];
	}
}

/*
 * Building `out' representation for various data types.
 */

rt_public EIF_REFERENCE c_outu(EIF_NATURAL_32 i)
{
	RT_GET_CONTEXT
	register int len;
	len = sprintf(buffero, "%u", i);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE c_outu64(EIF_NATURAL_64 i)
{
	RT_GET_CONTEXT
	register int len;
	len = sprintf(buffero, "%" EIF_NATURAL_64_DISPLAY, i);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE c_outi(EIF_INTEGER i)
{
	RT_GET_CONTEXT
	register int len;
	len = sprintf(buffero, "%d", i);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE c_outi64(EIF_INTEGER_64 i)
{
	RT_GET_CONTEXT
	register int len;
	len = sprintf(buffero, "%" EIF_INTEGER_64_DISPLAY, i);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE c_outr32(EIF_REAL_32 f)
{
	RT_GET_CONTEXT;
	int len;
	len = c_buffero_outr32(f);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE c_outr64(EIF_REAL_64 d)
{
	RT_GET_CONTEXT;
	int len;
	len = c_buffero_outr64(d);
	return makestr(buffero, len);
}


rt_public EIF_REFERENCE c_outc(EIF_CHARACTER c)
{
	return makestr((char *) &c, 1);
}

rt_public EIF_REFERENCE c_outp(EIF_POINTER p)
{
	RT_GET_CONTEXT
	register int len;
	len = sprintf(buffero, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) p);
	return makestr(buffero, len);
}

rt_shared int c_buffero_outr32 (EIF_REAL_32 f)
{
	RT_GET_CONTEXT
	if (f != f) {
		return sprintf(buffero, "NaN");
	} else if (f == eif_real_32_negative_infinity) {
		return sprintf(buffero, "-Infinity");
	} else if (f == eif_real_32_positive_infinity) {
		return sprintf(buffero, "Infinity");
	} else {
		return sprintf(buffero, "%g", f);
	}
}

rt_shared int c_buffero_outr64 (EIF_REAL_64 d)
{
	RT_GET_CONTEXT
	if (d != d) {
		return sprintf(buffero, "NaN");
	} else if (d == eif_real_64_negative_infinity) {
		return sprintf(buffero, "-Infinity");
	} else if (d == eif_real_64_positive_infinity) {
		return sprintf(buffero, "Infinity");
	} else {
		return sprintf(buffero, "%.17g", d);
	}
}


/*
doc:</file>
*/
