/*
	description: "Unit tests for rt_vector.h."
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

#include "rt_min_unit.c"
#include "rt_vector.h"

RT_DECLARE_VECTOR (rt_vector_char, char)
RT_DECLARE_VECTOR (rt_vector_intp, int*)

static struct rt_vector_char* cvec;
static struct rt_vector_intp* intpvec;

/*
 * Setup routines
 */

static void setup (void)
{
	cvec = rt_vector_char_create ();
	intpvec = rt_vector_intp_create ();
}

static void cleanup (void)
{
	rt_vector_char_destroy (cvec);
	cvec = NULL;
	rt_vector_intp_destroy(intpvec);
	intpvec = NULL;
}

/*
 * Test routines.
 */

/* Test initialization features on char type. */
static void test_cvec_create_delete (void)
{	
	int error = T_OK;
	mu_assert ("No vector allocated.", cvec != NULL);
	mu_assert ("Area is not NULL.", cvec->area == NULL);
	mu_assert ("Size and capacity are not zero.", cvec->capacity == 0 && cvec->count == 0);
	
	error = rt_vector_char_reserve (cvec, 32);
	mu_assert ("An error has happened.", T_OK == error);
	mu_assert ("Area is NULL.", cvec->area != NULL);
	mu_assert ("Capacity is wrong.", cvec->capacity == 32);
	mu_assert ("Size is not zero.", cvec->count == 0);
	
	rt_vector_char_deinit (cvec);
	
	mu_assert ("Area is not NULL.", cvec->area == NULL);
	mu_assert ("Size and capacity are not zero.", cvec->capacity == 0 && cvec->count == 0);
}

/* Test initialization features on int pointer type. */
static void test_intpvec_create_delete (void)
{
	int error = T_OK;
	
	mu_assert ("No vector allocated.", intpvec != NULL);
	mu_assert ("Area is not NULL.", intpvec->area == NULL);
	mu_assert ("Size and capacity are not zero.", intpvec->capacity == 0 && intpvec->count == 0);
	
	error = rt_vector_intp_reserve (intpvec, 32);
	mu_assert ("An error has happened.", T_OK == error);
	mu_assert ("Area is NULL.", intpvec->area != NULL);
	mu_assert ("Capacity is wrong.", intpvec->capacity == 32);
	mu_assert ("Size is not zero.", intpvec->count == 0 && rt_vector_intp_count(intpvec) == 0);
	
	rt_vector_intp_deinit (intpvec);
	
	mu_assert ("Area is not NULL.", intpvec->area == NULL);
	mu_assert ("Size and capacity are not zero.", intpvec->capacity == 0 && intpvec->count == 0);
}

/* Test the stack manipulation features 'extend', 'last' and 'remove_last' */
static void test_intpvec_push_pop (void)
{
	int stack_variable = 0;
	int error = T_OK;
	int* result = NULL;
	mu_assert ("Not empty", intpvec -> area == NULL);
	
	error = rt_vector_intp_extend (intpvec, &stack_variable);
	
	mu_assert ("No area allocated", intpvec->area != NULL);
	mu_assert ("Wrong count", intpvec->count == 1);
	mu_assert ("Wrong capacity", intpvec->capacity == RT_VECTOR_FIRST_RESERVE);
	
	result = rt_vector_intp_last (intpvec);
	mu_assert ("No error", T_OK == error);
	mu_assert ("Correct value", result == &stack_variable);
	
	rt_vector_intp_remove_last (intpvec);
	mu_assert ("No error", T_OK == error);
	mu_assert ("Wrong count", intpvec->count == 0);
}

/* Test correctness with many elements. */
static void test_cvec_many_push_pop (void)
{
	char c = '\0';
	size_t i = 0;
	int error = T_OK;
	size_t elements = 1000000;
	mu_assert ("Not empty", cvec-> area == NULL);
	
	for (i=0; i<elements; i++) {
		c = (char) i % 256;
		error = rt_vector_char_extend (cvec, c);
		mu_assert ("An error happened.", error == T_OK);
		mu_assert ("Vector is empty.", cvec->area != NULL && cvec->capacity > 0);
		mu_assert ("Size after push is wrong.", rt_vector_char_count (cvec) == (i+1));
		mu_assert ("Value is wrong.", rt_vector_char_item (cvec, i) == c);
		mu_assert ("Element pointer is wrong.",  *rt_vector_char_item_pointer (cvec, i) == c);
		mu_assert ("Last element is wrong.", rt_vector_char_last (cvec) == c);
		mu_assert ("Last element pointer is wrong.", *rt_vector_char_last_pointer (cvec) == c);
	}
	
	for (i=0; i<elements; i++) {
		rt_vector_char_remove_last (cvec);
		mu_assert ("Size after pop is wrong.", rt_vector_char_count (cvec) == (elements-i-1));
	}
}

/* Test the array access features  'put' and 'item' */
static void test_cvec_item_put (void)
{
	int error = T_OK;
	mu_assert ("Not empty.", cvec -> area == NULL);
	
	error = rt_vector_char_extend (cvec, 'a');
	mu_assert ("An error happened.", error == T_OK);
	error = rt_vector_char_extend (cvec, 'b');
	mu_assert ("An error happened.", error == T_OK);
	
	mu_assert ("First element not 'a'.", rt_vector_char_item (cvec, 0) == 'a');
	mu_assert ("Second element not 'b'.", rt_vector_char_item (cvec, 1) == 'b');
	mu_assert ("Size is wrong.", rt_vector_char_count (cvec) == 2);
	
	rt_vector_char_put (cvec, 0, 'c');
	rt_vector_char_put (cvec, 1, 'd');
	
	mu_assert ("First element not 'c'.", rt_vector_char_item (cvec, 0) == 'c');
	mu_assert ("Second element not 'd'.", rt_vector_char_item (cvec, 1) == 'd');

}

/*
 * Test suite definition and main().
 */

static mu_function_t my_tests [] = {
	test_cvec_create_delete,
	test_intpvec_create_delete,
	test_intpvec_push_pop,
	test_cvec_many_push_pop,
	test_cvec_item_put,
	(mu_function_t) NULL
};

MU_MAIN_SETUP (my_tests, setup, cleanup)


/* A compile-only test */
struct complex {
	double real;
	double imaginary;
};
RT_DECLARE_VECTOR (rt_vector_complex, struct complex)

