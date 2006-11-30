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

#ifndef	__mem_alloc_h
#define	__mem_alloc_h


/* Byte and address manipulation */

#define offset(addr,n) (((char *) (addr)) + (n))
#define pointer_size (sizeof (void *))
#define nth_pointer(addr,n) (((void **) addr)[n])

/* Memory manipulation macros. */

#define copy_nongc_memory(src,dest,size) \
  memcpy((char *) (dest), (char *) (src), (int) (size))

#define store_pointer(p,dest,offset) \
  ((void **) (dest))[offset] = ((void *) p)

#endif
