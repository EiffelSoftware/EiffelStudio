/*

 #####    #####            ##     ####    ####   ######  #####    #####         #    # 
 #    #     #             #  #   #       #       #       #    #     #           #    #  
 #    #     #            #    #   ####    ####   #####   #    #     #           ######
 #####      #            ######       #       #  #       #####      #     ###   #    # 
 #   #      #            #    #  #    #  #    #  #       #   #      #     ###   #    # 
 #    #     #   #######  #    #   ####    ####   ######  #    #     #     ###   #    # 

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


#define INTERNAL_CHECK(type, tag, exp) \
	if (!(exp)) \
		printf ("\n%s violation: %s\n\tin file %s at line %d:\n\t%s\n", \
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
