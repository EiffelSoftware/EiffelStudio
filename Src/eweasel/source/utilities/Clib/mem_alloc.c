/*
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

*/

#include <eif_eiffel.h>
#include <eif_except.h>
#include <stddef.h>

/* Return a pointer to newly allocated memory of at least `size' bytes
   which won't be garbage collected or moved by the Eiffel garbage
   collector.  If the allocation fails, raise an exception. */

EIF_POINTER allocate_nongc_memory (EIF_INTEGER size) {
  EIF_POINTER result;

  result = (EIF_POINTER) malloc((unsigned) size);
  if (result == NULL) {
    enomem();
  }
  return result;
}

/* Free memory pointed to by `ptr' which is not subject to garbage
   collection by the Eiffel garbage collector. */

void free_nongc_memory (EIF_POINTER ptr) {
  (void) free ((char *) ptr);
}

