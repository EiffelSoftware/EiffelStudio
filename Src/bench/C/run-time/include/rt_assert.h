/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
 Assertion checking of C code. All assertions takes a tag and the expression
 to be evaluated:
	* COMPILE_CHECK: check at compile time some property we want to satisfy
	* REQUIRE: precondition of a C routine
	* ENSURE: postcondition of a C routine
	* CHECK: check in C routine body
*/

#ifndef _rt_assert_h_
#define _rt_assert_h_

#include "eif_config.h"
#include "eif_confmagic.h"
#include <stdio.h>

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
extern int ise_printf (char *StrFmt, ...);

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
