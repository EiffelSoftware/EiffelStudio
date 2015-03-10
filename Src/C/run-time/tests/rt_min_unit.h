/*
	description: "A minimal unit testing framework for the Eiffel runtime."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2015, Eiffel Software."
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

#ifndef _rt_min_unit_h_
#define _rt_min_unit_h_

/*
 * Define the EIF_FUNCTION macro.
 * Some compilers may not support it, so we
 * just expand it to "<unknown>" on untested
 * platforms.
 */
#if defined __GNUC__ && __GNUC__ >= 2
#	define EIF_FUNCTION __FUNCTION__
#else
#	define EIF_FUNCTION "<unknown>"
#endif

/*
 * The function type used throughout eif_min_unit.
 * A test function takes no arguments and returns nothing.
 */
typedef void (*mu_function_t) (void);

/*
doc:	<routine name="mu_assert" return_type="void" export="public">
doc:		<summary> Check if 'test' is true. If not, abort the current function. </summary>
doc:		<param name="message" type="const char*"> The message tag to be displayed if the assertion fails. </param>
doc:		<param name="test" type="int"> The test to be performed. Usually this is an expression such as p!=NULL </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
#define mu_assert(message, test) mu_assert_impl ((message), (test), __LINE__, __FILE__, EIF_FUNCTION)

/*
doc:	<routine name="mu_run_test_suite" return_type="void" export="public">
doc:		<summary> Run all tests in 'a_test_suite'. </summary>
doc:		<param name="a_test_suite" type="mu_function_t*"> A NULL-terminated array of pointers to test functions to be executed. </param>
doc:		<param name="a_prepare" type="mu_function_t"> A setup function to be called before each test. May be NULL. </param>
doc:		<param name="a_cleanup" type="mu_function_t"> A cleanup function to be called after each test (also after failing tests). May be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:		<fixme> The unit test framework is neither thread-safe nor can it handle segmentation faults caused by test functions </fixme>
doc:	</routine>
*/
void mu_run_test_suite (mu_function_t* a_test_suite, mu_function_t a_prepare, mu_function_t a_cleanup);


/* Implementation of mu_assert(). Do not call this feature directly. */
void mu_assert_impl (const char* message, int test, int line, const char* file, const char* function);

/*
 * MU_MAIN_SETUP defines a main function
 * that runs the tests in the statically defined
 * array 'a_test_suite', with setup function 'a_setup'
 * and cleanup function 'a_cleanup'.
 */
#define MU_MAIN_SETUP(a_test_suite, a_prepare, a_cleanup) \
int main (void) { \
	mu_run_test_suite (& ((a_test_suite)[0]), a_prepare, a_cleanup); \
	return 0; \
}

/*
 * MU_MAIN defines a main function
 * that runs the tests in the statically defined
 * array 'a_test_suite'.
 */
#define MU_MAIN(a_test_suite) MU_MAIN_SETUP (a_test_suite, NULL, NULL)

#endif /* _rt_min_unit_h_ */


/* 
 * A minimal example on how to use this framework:
 * Note: By including the c file, you can avoid dealing with multiple compilation units.

#include "rt_min_unit.c"

void my_passing_test (void)
{
	mu_assert ("Oops...", 1==1);
	return NULL;
}

void my_failing_test (void)
{
	mu_assert ("Intended failure", 1 == 2);
	return NULL;
}

static mu_function_t my_test_suite [] = {
	my_passing_test,
	my_failing_test,
	(mu_function_t) NULL
};

MU_MAIN (my_test_suite)

*/
