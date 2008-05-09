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

void rv_failure (char *a_msg) {
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

void print_info() {
	struct align_test t;
	struct align_test2 t2;

	printf ("Size of overhead %d\n", OVERHEAD);
	printf ("Expected alignment %d\n", MEM_ALIGNBYTES);
	printf ("Computed alignment EIF_REAL_64 %d\n", (char *) &t.d - (char *) &t);
	printf ("Computed alignment EIF_REAL_32 %d\n", (char *) &t2.r - (char *) &t2);
}

int randomizer (int i) {
	return i % 100;
}

void double_alignment_speed_test () {
	double *pd = (double *) malloc (sizeof(double) * 10005);
	double d;
	int i, j;

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
}


int main(int argc, char **argv)
{
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
}

