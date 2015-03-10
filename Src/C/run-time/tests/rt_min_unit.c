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

#include "rt_min_unit.h"

#include <stdio.h>
#include <setjmp.h>

/*
doc:	<attribute name="assertion_jump_buffer" return_type="jmp_buf" export="private">
doc:		<summary> The jump buffer used to execute a longjmp() out of a failed test case.</summary>
doc:		<access> Read / Write, only in mu_assert_impl and mu_run_test_suite. </access>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</attribute>
*/
static jmp_buf assertion_jump_buffer;

/*
doc:	<routine name="mu_assert_impl" return_type="void" export="public">
doc:		<summary> Check if 'test' is true. If not it prints an error message and aborts the current test by executing a longjmp(). </summary>
doc:		<param name="message" type="const char*"> The message tag to be displayed if the assertion fails. </param>
doc:		<param name="test" type="int"> The outcome of the assertion check. </param>
doc:		<param name="line" type="int"> The source code line where the assertion is located. </param>
doc:		<param name="file" type="const char*"> The source file where the assertion is located.</param>
doc:		<param name="file" type="const char*"> The name of the enclosing function in which the message is located.</param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
void mu_assert_impl (const char* message, int test, int line, const char* file,  const char* function)
{
	if (!test) {
		printf ("\n\tAn assertion failed: Line %u in %s (function %s).\n\tError message: %s\n", line, file, function, message);
		longjmp (assertion_jump_buffer, 1);
	}
}

/* See description in header. */
void mu_run_test_suite (mu_function_t* a_test_suite, mu_function_t a_prepare, mu_function_t a_cleanup)
{
	int passing_tests = 0;
	int offset = 0;
	mu_function_t current_test = NULL;
	
		/* Loop over all tests and print any error messages on the fly. */
	for (offset = 0; NULL != a_test_suite [offset]; offset++) {
		
		if (a_prepare) {
			a_prepare();
		}
		
			/* Prepare the longjmp for a failed assertion. */
		if (setjmp (assertion_jump_buffer)) {

				/* An assertion has failed! */

		} else {
				/* Run the test */
			current_test = a_test_suite [offset];
			current_test ();
				/* If we reach this, everything's fine. */
			++passing_tests;
		}

		if (a_cleanup) {
			a_cleanup ();
		}
	}

	if (passing_tests == offset) {
		printf ("OK: All %u tests passed.\n", offset);
	} else {
		printf ("ERROR: Only %u / %u tests passed.\n", passing_tests, offset);
	}
}
