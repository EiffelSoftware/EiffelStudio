/*
	description: "[
			Assertion checking of C code. All assertions takes a tag and the expression
			to be evaluated:
				* COMPILE_CHECK: check at compile time some property we want to satisfy
				* REQUIRE: precondition of a C routine
				* ENSURE: postcondition of a C routine
				* CHECK: check in C routine body
			]"
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

#ifndef _rt_assert_h_
#define _rt_assert_h_

#include "eif_config.h"
#include "eif_confmagic.h"
#include <stdio.h>
#ifdef EIF_ASSERTIONS
#include <stdarg.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_ASSERTIONS

	/* Assertions checked at compilation time */
#define COMPILE_CHECK(tag, exp) extern dummy_array_for_checking[(exp)?1:-1];

	/* To use instead of `printf' when a breakpoint needs to be inserted
	 * when assertion violation is reported. To do so, we have created
	 * `ise_printf' so that we can simply set a breakpoint in it.
	 */
rt_private int ise_printf (char *StrFmt, ...)
	/* To put a breakpoint when an assertion violation occurs. */
{
	va_list ap;
	int r;

	va_start (ap, StrFmt);
	r = vprintf (StrFmt, ap);
	va_end (ap);

	return r;
}

#define INTERNAL_CHECK(type, tag, exp) \
	if (!(exp)) \
		ise_printf ("\n%s violation: %s\n\tin file %s at line %d:\n\t%s\n", \
				(type), (tag), __FILE__, __LINE__, #exp);

	/* Precondition checking */
#define REQUIRE(tag,exp)	INTERNAL_CHECK("Precondition", (tag), (exp))

	/* Postcondition checking */
#define ENSURE(tag,exp)		INTERNAL_CHECK("Postcondition", (tag), (exp))

	/* Check statement */
#define CHECK(tag, exp)		INTERNAL_CHECK("Check", (tag), (exp))

#else
#define COMPILE_CHECK(tag, exp)
#define REQUIRE(tag, exp)
#define ENSURE(tag, exp)
#define CHECK(tag, exp)
#endif

#ifdef __cplusplus
}
#endif

#endif
