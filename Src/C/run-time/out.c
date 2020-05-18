/*
	description: "Routines for printing an Eiffel object."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2020, Eiffel Software."
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
#include "eif_globals.h"
#include "rt_malloc.h"
#include "rt_wbench.h"
#include "rt_macros.h"
#include "rt_constants.h"
#include "rt_gen_types.h"
#include "rt_assert.h"
#include <string.h>
#include <stdio.h>
#include "rt_globals_access.h"
#include "rt_string.h"

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

/*
doc:	<routine name="rt_copy_s1_to_s4" return_type="void" export="private">
doc:		<summary>Expand 1-byte sequence of given length to 4-byte sequence.</summary>
doc:		<param name="p1" type="char*">Source.</param>
doc:		<param name="p4" type="char*">Destination.</param>
doc:		<param name="n" type="char*">Length.</param>
doc:		<synchronization>None.</synchronization>
doc:		<thread_safety>Safe.</thread_safety>
doc:	</routine>
*/
rt_private rt_inline void rt_copy_s1_to_s4 (const char * p1, EIF_CHARACTER_32 * p4, int n) {
	char c;

	for (; n > 0; n--)
	{
		c = * (p1 ++);
		* (p4 ++) = (EIF_CHARACTER_32)
#			if BYTEORDER == 0x1234
				c
#			else
				((c >> 24) & 0xff) |
				((c >> 08) & 0xff00) |
				((c << 08) & 0xff0000) |
				((c << 24) & 0xff000000)
#			endif
			;
	}
}

rt_private void write_string(const char *str);	/* Write a string in `tagged_out' */
rt_private void write_char(EIF_CHARACTER_8 c);		/* Write a character */
rt_private void write_attribute_character(EIF_CHARACTER_8 c);		/* Write a character as an Eiffel attribute */
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

rt_public EIF_REFERENCE c_generator_of_type (EIF_TYPE ftype)
	/* Class name associated with dynamic type `dftype'.
	 * Return a reference on an Eiffel instance of STRING_8.
	 */
{
	const char *generator;
	generator = System (To_dtype(ftype.id)).cn_generator;
	return makestr (generator, strlen (generator));
}

rt_public EIF_REFERENCE c_generator_of_type_32 (EIF_TYPE ftype)
	/* Class name associated with dynamic type `dftype`.
	 * Return a reference on an Eiffel instance of STRING_32.
	 */
{
	EIF_REFERENCE result;

	result = string_32_from_char_8 (System (To_dtype(ftype.id)).cn_generator);
	if (result == (EIF_REFERENCE) 0) {
		enomem(MTC_NOARG);
	}
	return result;
}

rt_public EIF_REFERENCE c_tagged_out(EIF_REFERENCE object)
{
	/* Write a tagged out printing in an string.
	 * Return a pointer on an Eiffel 8-bit string object.
	 */
	RT_GET_CONTEXT
	EIF_REFERENCE result;		/* The Eiffel string returned */

	tagged_out = build_out(object);	/* Build tagged out string for object */
	result = makestr(tagged_out, strlen(tagged_out));
	eif_rt_xfree(tagged_out);	/* Buffer not needed anymore */

	return result;		/* An Eiffel string */
}

rt_public EIF_REFERENCE c_tagged_out_32 (EIF_REFERENCE object)
{
	/* Write a tagged out printing in an string.
	 * Return a pointer on an Eiffel 32-bit string object.
	 */
	RT_GET_CONTEXT
	EIF_REFERENCE result;

		/* Build 8-bit tagged out string for object. */
	tagged_out = build_out(object);
		/* Create 32-bit string from it. */
	result = string_32_from_char_8 (tagged_out);
		/* Release the temporary buffer. */
	eif_rt_xfree(tagged_out);
		/* Raise an exception if string could not be created. */
	if (result == (EIF_REFERENCE) 0) {
		enomem(MTC_NOARG);
	}
	return result;
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
	write_string (eif_typename_id(Dftype(object)));
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
	const struct cnode *obj_desc;	   /* Object type description */
	long nb_attr;				 /* Attribute number */
	const uint32 *types;                /* Attribute types */
#ifndef WORKBENCH
	const long *offsets;			   /* Attribute offsets table */
#else
	const int32 *cn_attr;			   /* Attribute keys */
	long offset;
#endif
	EIF_TYPE_INDEX dyn_type;			   /* Object dynamic type */
	EIF_REFERENCE o_ref;
	const char **names;				 /* Attribute names */
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
		offset = wattr(cn_attr[i], dyn_type);
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
		case SK_CHAR8:
			/* Character attribute */
			write_attribute_character (*o_ref);
			break;
		case SK_CHAR32:
			/* Wide character attribute */
			sprintf(buffero, "CHARACTER_32 = U+%x\n", *(EIF_CHARACTER_32 *)o_ref);
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
		case SK_EXP:
			/* Expanded attribute */
			write_string("expanded ");
			write_string(eif_typename_id(Dftype(o_ref)));
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
				write_string(eif_typename_id(Dftype(reference)));
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
				write_string(eif_typename_id(Dftype(o_ref)));
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
					sprintf(buffero, "CHARACTER_32 = U+%x\n", *(EIF_CHARACTER_32 *)o_ref);
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
					write_string("UNKNOWN\n");
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
				write_string (eif_typename_id(Dftype(reference)));
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
			case EIF_CHARACTER_8_CODE:
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
					write_string(eif_typename_id(Dftype(eif_reference_item(object, i))));
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
			case EIF_CHARACTER_32_CODE:
				sprintf(buffero, "CHARACTER_32 = U+%x\n", eif_wide_character_item(object,i));
				write_string(buffero);
				break;
		}
	}
}

rt_private void write_char(EIF_CHARACTER_8 c)
{
		/* Print `c' in `tagged_out'. */
	RT_GET_CONTEXT
	tagged_len += sizeof(EIF_CHARACTER_8);
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

rt_private void write_attribute_character (EIF_CHARACTER_8 c)
							/* The character */
		  		/* Where it should be written */
{
		/* Write a character in `buffer' */
	write_string ("CHARACTER_8 = ");
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

rt_private void write_string(const char *str)
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

rt_public EIF_REFERENCE eif_out__u4_s4 (EIF_NATURAL_32 i)
{
		/* Longest NATURAL_32 value is 0xFFFFFFFF, or 4'294'967'295 decimal. */
		/* It requires at most 10 characters. */
	EIF_CHARACTER_32 buffer [10];
	register EIF_CHARACTER_32 * p;
	register EIF_NATURAL_32 prev;

	p = & (buffer [sizeof (buffer) / sizeof (buffer [0])]);
	do {
		prev = i;
		i /= 10;
		* (--p) = (EIF_CHARACTER_32) (prev - i * 10 + '0')
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	} while (i > 0);
	return RTMS32_EX ((char *) p, & (buffer [sizeof (buffer) / sizeof (buffer [0])]) - p);
}

rt_public EIF_REFERENCE eif_out__u8_s4 (EIF_NATURAL_64 i)
{
		/* Longest NATURAL_64 value is 0xFFFFFFFF_FFFFFFFF, or 18'446'744'073'709'551'615 decimal. */
		/* It requires at most 20 characters. */
	EIF_CHARACTER_32 buffer [20];
	register EIF_CHARACTER_32 * p;
	register EIF_NATURAL_64 prev;

	p = & (buffer [sizeof (buffer) / sizeof (buffer [0])]);
	do {
		prev = i;
		i /= 10;
		* (--p) = (EIF_CHARACTER_32) (prev - i * 10 + '0')
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	} while (i > 0);
	return RTMS32_EX ((char *) p, & (buffer [sizeof (buffer) / sizeof (buffer [0])]) - p);
}

rt_public EIF_REFERENCE eif_out__i4_s4 (EIF_INTEGER_32 i)
{
		/* Longest INTEGER_32 value is -0x80000000, or -2'147'483'648 decimal. */
		/* It requires at most 11 characters. */
	EIF_CHARACTER_32 buffer [11];
	register EIF_CHARACTER_32 * p;
	register EIF_INTEGER_32 prev;

	p = & (buffer [sizeof (buffer) / sizeof (buffer [0])]);
	do {
		prev = i;
		i /= 10;
		* (--p) = (EIF_CHARACTER_32) "9876543210123456789" [prev - i * 10 + 9]
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	} while (i > 0);
	if (prev < 0) {
		* (--p) = (EIF_CHARACTER_32) '-'
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	}
	return RTMS32_EX ((char *) p, & (buffer [sizeof (buffer) / sizeof (buffer [0])]) - p);
}

rt_public EIF_REFERENCE eif_out__i8_s4 (EIF_INTEGER_64 i)
{
		/* Longest EIF_INTEGER_64 value is -0x80000000_00000000, or -9'223'372'036'854'775'808 decimal. */
		/* It requires at most 20 characters. */
	EIF_CHARACTER_32 buffer [20];
	register EIF_CHARACTER_32 * p;
	register EIF_INTEGER_64 prev;

	p = & (buffer [sizeof (buffer) / sizeof (buffer [0])]);
	* p = (EIF_CHARACTER_32) 0;
	do {
		prev = i;
		i /= 10;
		* (--p) = (EIF_CHARACTER_32) "9876543210123456789" [prev - i * 10 + 9]
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	} while (i > 0);
	if (prev < 0) {
		* (--p) = (EIF_CHARACTER_32) '-'
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	}
	return RTMS32_EX ((char *) p, & (buffer [sizeof (buffer) / sizeof (buffer [0])]) - p);
}

rt_public EIF_REFERENCE c_outr32(EIF_REAL_32 f)
{
	RT_GET_CONTEXT
	int len;
	len = c_buffero_outr32(f);
	return makestr(buffero, len);
}

rt_private const char * eif_string_nan = "N\0\0\0a\0\0\0N\0\0\0";
rt_private const char * eif_string_p_infinity = "I\0\0\0n\0\0\0f\0\0\0i\0\0\0n\0\0\0i\0\0\0t\0\0\0y\0\0\0";
rt_private const char * eif_string_n_infinity = "-\0\0\0I\0\0\0n\0\0\0f\0\0\0i\0\0\0n\0\0\0i\0\0\0t\0\0\0y\0\0\0";

rt_public EIF_REFERENCE eif_out__r4_s4 (EIF_REAL_32 r)
{
		/* Maximum number of decimal digits is 9. */
		/* Plus sign, dot, exponent symbol, exponent sign, 2 exponent digits, terminating 0. */
	char buffer_1 [9 + 1 + 1 + 1 + 1 + 2 + 1];
		/* Terminating 0 is not needed. */
	EIF_CHARACTER_32 buffer_4 [sizeof buffer_1 - 1];
	int n;

	if (r != r) {
		return RTMS32_EX (eif_string_nan, 3);
	} else if (r == eif_real_32_negative_infinity) {
		return RTMS32_EX (eif_string_n_infinity, 9);
	} else if (r == eif_real_32_positive_infinity) {
		return RTMS32_EX (eif_string_p_infinity, 8);
	} else {
		n = sprintf(buffer_1, "%g", r);
		rt_copy_s1_to_s4 (buffer_1, buffer_4, n);
		return RTMS32_EX ((char *) & buffer_4, n);
	}
}

rt_public EIF_REFERENCE c_outr64(EIF_REAL_64 d)
{
	RT_GET_CONTEXT
	int len;
	len = c_buffero_outr64(d);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE eif_out__r8_s4 (EIF_REAL_64 r)
{
		/* Maximum number of decimal digits is 17. */
		/* Plus sign, dot, exponent symbol, exponent sign, 3 exponent digits, terminating 0. */
	char buffer_1 [17 + 1 + 1 + 1 + 1 + 3 + 1];
		/* Terminating 0 is not needed. */
	EIF_CHARACTER_32 buffer_4 [sizeof buffer_1 - 1];
	int n;

	if (r != r) {
		return RTMS32_EX (eif_string_nan, 3);
	} else if (r == eif_real_64_negative_infinity) {
		return RTMS32_EX (eif_string_n_infinity, 9);
	} else if (r == eif_real_64_positive_infinity) {
		return RTMS32_EX (eif_string_p_infinity, 8);
	} else {
		n = sprintf(buffer_1, "%.17g", r);
		rt_copy_s1_to_s4 (buffer_1, buffer_4, n);
		return RTMS32_EX ((char *) & buffer_4, n);
	}
}

rt_public EIF_REFERENCE c_outc(EIF_CHARACTER_8 c)
{
	return makestr((char *) &c, 1);
}

rt_public EIF_REFERENCE eif_out__c1_s4 (EIF_CHARACTER_8 c)
{
	EIF_CHARACTER_32 buffer = (EIF_CHARACTER_32) c
#			if BYTEORDER != 0x1234
				<< 24
#			endif
			;
	return RTMS32_EX ((char *) & buffer, 1);
}

rt_private const char * rt_hexadecimal_digit = "0123456789ABCDEF";

rt_public EIF_REFERENCE eif_out__c4_s1 (EIF_CHARACTER_32 c)
{
		/* One byte requires 2 hexadecimal digits, plus leading U+ and terminating 0. */
	char buffer [sizeof (EIF_CHARACTER_32) * 2 + 3];
	int n;

	if (c < 0x80) {
			/* Plain ASCII code. */
		return eif_out__c1_s1 ((EIF_CHARACTER_8) c);
	}
	buffer [sizeof buffer - 1] = '\0';
	buffer [sizeof buffer - 2] = rt_hexadecimal_digit [c         & 0xF];
	buffer [sizeof buffer - 3] = rt_hexadecimal_digit [(c >>  4) & 0xF];
	buffer [sizeof buffer - 4] = rt_hexadecimal_digit [(c >>  8) & 0xF];
	buffer [sizeof buffer - 5] = rt_hexadecimal_digit [(c >> 12) & 0xF];
	buffer [sizeof buffer - 6] = rt_hexadecimal_digit [(c >> 16) & 0xF]; /* Optional. */
	buffer [sizeof buffer - 7] = rt_hexadecimal_digit [(c >> 20) & 0xF]; /* Optional. */
	buffer [sizeof buffer - 8] = rt_hexadecimal_digit [(c >> 24) & 0xF]; /* Optional. */
	buffer [sizeof buffer - 9] = rt_hexadecimal_digit [(c >> 28) & 0xF]; /* Optional. */
		/* Minimum 4 hexadecimal digits are required. */
		/* Compute the number of optinal digits. */
	n = ((c >> 16) && 1) + ((c >> 20) && 1) + ((c >> 24) && 1) + ((c >> 28) && 1);
	buffer [(sizeof buffer - 6) - n] = '+';
	buffer [(sizeof buffer - 7) - n] = 'U';
	return makestr (& (buffer [(sizeof buffer - 7) - n]), n + 6);
}

rt_public EIF_REFERENCE eif_out__c4_s4 (EIF_CHARACTER_32 c)
{
	EIF_CHARACTER_32 buffer =
#			if BYTEORDER == 0x1234
				c
#			else
				((c >> 24) & 0xff) |
				((c >> 08) & 0xff00) |
				((c << 08) & 0xff0000) |
				((c << 24) & 0xff000000)
#			endif
			;
	return RTMS32_EX ((char *) & buffer, 1);
}

rt_public EIF_REFERENCE c_outp(EIF_POINTER p)
{
	RT_GET_CONTEXT
	register int len;
	len = sprintf(buffero, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) p);
	return makestr(buffero, len);
}

rt_public EIF_REFERENCE eif_out__p_s4 (EIF_POINTER p)
{
		/* One byte requires 2 hexadecimal digits, plus leading 0x and terminating 0. */
	char buffer_1 [sizeof (rt_uint_ptr) * 2 + 3];
		/* Terminating 0 is not needed. */
	EIF_CHARACTER_32 buffer_4 [sizeof buffer_1 - 1];
	int n;

	n = sprintf(buffer_1, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) p);
	rt_copy_s1_to_s4 (buffer_1, buffer_4, n);
	return RTMS32_EX ((char *) & buffer_4, n);
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
