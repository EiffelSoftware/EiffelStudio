/*
	description: "Ensure that manually configured runtime works the way it is supposed to for your platform."
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

/*
doc:<file name="runtime_validation.c" version="$Id$" summary="Convert .x file into compilable .c files">
*/

#define EIF_ASSERTIONS

#include "eif_eiffel.h"
#include "eif_offset.h"
#include "rt_malloc.h"
#include "rt_assert.h"

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

rt_private void rv_failure (char *a_msg) {
	printf ("%s\n", a_msg);
	exit(1);
}

struct align_test {
	EIF_CHARACTER a;
	EIF_REAL_64 d;
};

struct align_test2 {
	EIF_CHARACTER a;
	EIF_REAL_32 r;
};

struct eif_ex_type {
	union overhead overhead;
	char data[4];
};

rt_private void print_info(void) {
	struct align_test t;
	struct align_test2 t2;
	struct eif_ex_type t3;

	printf ("Size of overhead %ld\n", OVERHEAD);
	printf ("Expected alignment %d\n", MEM_ALIGNBYTES);
	printf ("Computed alignment EIF_REAL_64 %ld\n", (char *) &t.d - (char *) &t);
	printf ("Computed alignment EIF_REAL_32 %ld\n", (char *) &t2.r - (char *) &t2);
	printf ("Expanded offset between overhead and data %ld\n", (char *) &t3.data - (char *) &t3.overhead);
}

rt_private int randomizer (int i) {
	return i % 100;
}

rt_private void double_alignment_speed_test (void) {
	double *pd = (double *) malloc (sizeof(double) * 10005);
	double d;
	int i, j;

	if (pd) {
		memset(pd, 0, sizeof(double) * 10005);
	/* Comment out the line below to test if a double incorrectly aligned causes
	 * either a segfault or a slow down in performance. */
	/*	pd = (double *) ((char *)pd + 4); */
		for (j = 1; j < 100000; j++) {
			for (i = 0; i < 10000; i++) {
				d = pd [i];
				pd [i] = d + randomizer (i);
			}
		}

		for (i = 0; i < 1000; i++) {
			printf ("%g\n", pd [i]);
		}
	} else {
		printf ("Failure in allocating memory in `double_alignment_speed_test'\n");
	}
}


int main(int argc, char **argv)
{
	struct eif_ex_type t3;

	print_info();

	CHECK ("TAG: Proper header alignment", (OVERHEAD % MEM_ALIGNBYTES) == 0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,0,0,0,0,0,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(1,0,0,0,0,0,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,1,0,0,0,0,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,0,1,0,0,0,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,0,0,1,0,0,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,0,0,0,1,0,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,0,0,0,0,1,0) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((eif_r64off(0,0,0,0,0,0,1) % MEM_ALIGNBYTES) == 0));
	CHECK ("TAG: No gap for expanded between overhead and data", OVERHEAD == ((char *) &t3.data - (char *) &t3.overhead));

	return 0;
}

