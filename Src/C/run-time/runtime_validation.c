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
#include "rt_malloc.h"
#include "rt_assert.h"
#include "x2c.h"

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

void print_info() {
	struct align_test t;
	size_t n = OVERHEAD + sizeof(EIF_REAL_64);
	size_t mod;


	printf ("Size of overhead %d\n", OVERHEAD);
	printf ("Expected alignment %d\n", MEM_ALIGNBYTES);
	printf ("Computed alignment %d\n", (char *) &t.d - (char *) &t);
}

int main(int argc, char **argv)
{
	size_t offset;

	print_info();

	CHECK ("TAG: Proper header alignment", (OVERHEAD % MEM_ALIGNBYTES) == 0);
	offset = R64OFF(0,0,0,0,0,0,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(1,0,0,0,0,0,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(0,1,0,0,0,0,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(0,0,1,0,0,0,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(0,0,0,1,0,0,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(0,0,0,0,1,0,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(0,0,0,0,0,1,0);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
	offset = R64OFF(0,0,0,0,0,0,1);
	CHECK ("TAG: Proper EIF_REAL_64 alignment", ((offset % MEM_ALIGNBYTES) == 0));
}

