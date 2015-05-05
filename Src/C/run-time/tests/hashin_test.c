/*
	description: "Test hash-table implementation."
   	compilation: "cc hashin_test.c -I.. -I../include -I../../idrs -lm ../libfinalized.a -DISE_USE_ASSERT"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#include "rt_min_unit.c"
#include "hashin.c"

static void setup (void)
{
	initsig();
	initstk();
}

static void cleanup (void)
{
}


/*
 * Test routines.
 */

static void test_removal (void)
{
	struct htable ht;
	uint32 val;
	
	memset(&ht, 0, sizeof(struct htable));
	ht_create (&ht, 10, sizeof(uint32));

		/* We know the formulae of creation and for a requested size of 10, we will
		 * allocate for 10 + 10/2, that is 15 but since we take the closes prime number
		 * it will be 17. */
	CHECK("expected size", ht.h_capacity == 17);

		/* The following keys are not chosen by mistake, the table increment is modulo (17 - 1),
		 * the starting position is computed modulo 17. So we always choose a value constant to 17 x 16,
		 * here we chose the value just one above, 1, 272 + 1, 272 * 2 + 1, 272 * 3 + 1, .... */
	val = 1;
	ht_force(&ht, 1, &val);
	val = 273;
	ht_force(&ht, 273, &val);
	val = 545;
	ht_force(&ht, 545, &val);
	val = 817;
	ht_force(&ht, 817, &val);
	val = 1089;
	ht_force(&ht, 1089, &val);
	val = 1361;
	ht_force(&ht, 1361, &val);
	val = 1633;
	ht_force(&ht, 1633, &val);
	val = 1905;
	ht_force(&ht, 1905, &val);
	val = 2177;
	ht_force(&ht, 2177, &val);
	val = 2449;
	ht_force(&ht, 2449, &val);

	CHECK("present", 1 == *(uint *) ht_value(&ht, 1));
	CHECK("present", 273 == *(uint *) ht_value(&ht, 273));
	CHECK("present", 545 == *(uint *) ht_value(&ht, 545));
	CHECK("present", 817 == *(uint *) ht_value(&ht, 817));
	CHECK("present", 1089 == *(uint *) ht_value(&ht, 1089));
	CHECK("present", 1361 == *(uint *) ht_value(&ht, 1361));
	CHECK("present", 1633 == *(uint *) ht_value(&ht, 1633));
	CHECK("present", 1905 == *(uint *) ht_value(&ht, 1905));
	CHECK("present", 2177 == *(uint *) ht_value(&ht, 2177));
	CHECK("present", 2449 == *(uint *) ht_value(&ht, 2449));
	CHECK("not present", !ht_value(&ht, 6));

	ht_remove(&ht, 545);
	ht_remove(&ht, 817);
	ht_remove(&ht, 1633);
	ht_remove(&ht, 1905);

	CHECK("present", 1 == *(uint *) ht_value(&ht, 1));
	CHECK("present", 273 == *(uint *) ht_value(&ht, 273));
	CHECK("not present",  !ht_value(&ht, 545));
	CHECK("not present", !ht_value(&ht, 817));
	CHECK("present", 1089 == *(uint *) ht_value(&ht, 1089));
	CHECK("present", 1361 == *(uint *) ht_value(&ht, 1361));
	CHECK("not present", !ht_value(&ht, 1633));
	CHECK("not present", !ht_value(&ht, 1905));
	CHECK("present", 2177 == *(uint *) ht_value(&ht, 2177));
	CHECK("present", 2449 == *(uint *) ht_value(&ht, 2449));
	CHECK("not present", !ht_value(&ht, 6));
}


/*
 * Test suite definition and main().
 */

static mu_function_t my_tests [] = {
	test_removal,
	NULL
};

MU_MAIN_SETUP (my_tests, setup, cleanup)

