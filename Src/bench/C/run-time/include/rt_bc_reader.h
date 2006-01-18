/*
	description: "Byte code data reader."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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

#ifndef _rt_bc_reader_h_
#define _rt_bc_reader_h_

#include "eif_portable.h"
#include <string.h>
#include "rt_assert.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
doc:	<routine name="get_char8" return_type="EIF_CHARACTER" export="private">
doc:		<summary>Read an EIF_CHARACTER from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_CHARACTER value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_CHARACTER get_char8 (unsigned char **bc)
{
		/* Get EIF_CHARACTER stored at *bc in byte code array.  */
	EIF_CHARACTER result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_CHARACTER));
	*bc += sizeof(EIF_CHARACTER);
	return result;
}

/*
doc:	<routine name="get_char32" return_type="EIF_WIDE_CHAR" export="private">
doc:		<summary>Read an EIF_WIDE_CHAR from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_WIDE_CHAR value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_WIDE_CHAR get_char32 (unsigned char **bc)
{
		/* Get EIF_WIDE_CHAR stored at *bc in byte code array.  */
	EIF_WIDE_CHAR result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_WIDE_CHAR));
	*bc += sizeof(EIF_WIDE_CHAR);
	return result;
}

/*
doc:	<routine name="get_bool" return_type="EIF_BOOLEAN" export="private">
doc:		<summary>Read an EIF_BOOLEAN from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_BOOLEAN value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_BOOLEAN get_bool (unsigned char **bc)
{
		/* Get EIF_BOOLEAN stored at *bc in byte code array.  */
	EIF_BOOLEAN result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_BOOLEAN));
	*bc += sizeof(EIF_BOOLEAN);
	return result;
}

/*
doc:	<routine name="get_int8" return_type="EIF_INTEGER_8" export="private">
doc:		<summary>Read an EIF_INTEGER_8 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_INTEGER_8 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_INTEGER_8 get_int8 (unsigned char **bc)
{
		/* Get EIF_INTEGER_8 stored at *bc in byte code array.  */
	EIF_INTEGER_8 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_INTEGER_8));
	*bc += sizeof(EIF_INTEGER_8);
	return result;
}

/*
doc:	<routine name="get_int16" return_type="EIF_INTEGER_16" export="private">
doc:		<summary>Read an EIF_INTEGER_16 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_INTEGER_16 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_INTEGER_16 get_int16 (unsigned char **bc)
{
		/* Get EIF_INTEGER_16 stored at *bc in byte code array.  */
	EIF_INTEGER_16 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_INTEGER_16));
	*bc += sizeof(EIF_INTEGER_16);
	return result;
}

/*
doc:	<routine name="get_int32" return_type="EIF_INTEGER_32" export="private">
doc:		<summary>Read an EIF_INTEGER_32 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_INTEGER_32 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_INTEGER_32 get_int32(unsigned char **bc)
{
		/* Get EIF_INTEGER_32 stored at *bc in byte code array.  */
	EIF_INTEGER_32 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_INTEGER_32));
	*bc += sizeof(EIF_INTEGER_32);
	return result;
}

/*
doc:	<routine name="get_int64" return_type="EIF_INTEGER_64" export="private">
doc:		<summary>Read an EIF_INTEGER_64 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_INTEGER_64 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_INTEGER_64 get_int64(unsigned char **bc)
{
		/* Get EIF_INTEGER_64 stored at *bc in byte code array.  */
	EIF_INTEGER_64 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_INTEGER_64));
	*bc += sizeof(EIF_INTEGER_64);
	return result;
}

/*
doc:	<routine name="get_uint8" return_type="EIF_NATURAL_8" export="private">
doc:		<summary>Read an EIF_NATURAL_8 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_NATURAL_8 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_NATURAL_8 get_uint8 (unsigned char **bc)
{
		/* Get EIF_NATURAL_8 stored at *bc in byte code array.  */
	EIF_NATURAL_8 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_NATURAL_8));
	*bc += sizeof(EIF_NATURAL_8);
	return result;
}

/*
doc:	<routine name="get_uint16" return_type="EIF_NATURAL_16" export="private">
doc:		<summary>Read an EIF_NATURAL_16 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_NATURAL_16 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_NATURAL_16 get_uint16 (unsigned char **bc)
{
		/* Get EIF_NATURAL_16 stored at *bc in byte code array.  */
	EIF_NATURAL_16 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_NATURAL_16));
	*bc += sizeof(EIF_NATURAL_16);
	return result;
}

/*
doc:	<routine name="get_uint32" return_type="EIF_NATURAL_32" export="private">
doc:		<summary>Read an EIF_NATURAL_32 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_NATURAL_32 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_NATURAL_32 get_uint32(unsigned char **bc)
{
		/* Get EIF_NATURAL_32 stored at *bc in byte code array.  */
	EIF_NATURAL_32 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_NATURAL_32));
	*bc += sizeof(EIF_NATURAL_32);
	return result;
}

/*
doc:	<routine name="get_uint64" return_type="EIF_NATURAL_64" export="private">
doc:		<summary>Read an EIF_NATURAL_64 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_NATURAL_64 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_NATURAL_64 get_uint64(unsigned char **bc)
{
		/* Get EIF_NATURAL_64 stored at *bc in byte code array.  */
	EIF_NATURAL_64 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_NATURAL_64));
	*bc += sizeof(EIF_NATURAL_64);
	return result;
}

/*
doc:	<routine name="get_real32" return_type="EIF_REAL_32" export="private">
doc:		<summary>Read an EIF_REAL_32 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_REAL_32 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_REAL_32 get_real32(unsigned char **bc)
{
		/* Get EIF_REAL_32 stored at *bc in byte code array.  */
	EIF_REAL_32 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_REAL_32));
	*bc += sizeof(EIF_REAL_32);
	return result;
}

/*
doc:	<routine name="get_real64" return_type="EIF_REAL_64" export="private">
doc:		<summary>Read an EIF_REAL_64 from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<return>The read EIF_REAL_64 value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_REAL_64 get_real64(unsigned char **bc)
{
		/* Get EIF_REAL_64 stored at *bc in byte code array.  */
	EIF_REAL_64 result;

	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	memcpy(&result, *bc, sizeof(EIF_REAL_64));
	*bc += sizeof(EIF_REAL_64);
	return result;
}

/*
doc:	<routine name="get_string8" return_type="EIF_CHARACTER *" export="private">
doc:		<summary>Read a string made of EIF_CHARACTER from a byte code stream.</summary>
doc:		<param name="bc" type="unsigned char **">Stream from where data is going to be read.</param>
doc:		<param name="requested_length" type="EIF_INTEGER_32">Number of characters to read from string, if -1, we suppose it is a null terminated string.</param>
doc:		<return>The read EIF_CHARACTER * value.</return>
doc:		<thread_safety>Safe if `bc' is not used by more than one thread</thread_safety>
doc:		<synchronization>None required.</synchronization>
doc:	</routine>
*/

rt_private EIF_CHARACTER * get_string8(unsigned char **bc, EIF_INTEGER_32 requested_length)
{
		/* Get EIF_CHARACTER * stored at *bc in byte code array.  */
	EIF_CHARACTER * result;
	
	REQUIRE("bc_not_null", bc);
	REQUIRE("bc_data_not_null", *bc);

	result = (EIF_CHARACTER *) *bc;

	if (requested_length == -1) {
		*bc += strlen((char *)result) + 1;
	} else {
		*bc += requested_length + 1;
	}

	return result;
}

#ifdef __cplusplus
}
#endif

#endif
