/*
	description: "Definition of low level memory de/re/allocation routines."
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

#ifndef _eif_lmalloc_h_
#define _eif_lmalloc_h_

#include "eif_portable.h"


#ifdef LMALLOC_DEBUG
#include <stdio.h>
#define eif_malloc(x) (fprintf (stderr, "%s:%d\t| ", __FILE__, __LINE__), eiffel_malloc (x, __FILE__, __LINE__))
#define eif_calloc(x,y) (fprintf (stderr, "%s:%d\t| ", __FILE__, __LINE__), eiffel_calloc (x, y, __FILE__, __LINE__))
#define eif_realloc(x,y) (fprintf (stderr, "%s:%d\t| ", __FILE__, __LINE__), eiffel_realloc (x, y, __FILE__, __LINE__))
#define eif_free(x) (fprintf (stderr, "%s:%d\t| ", __FILE__, __LINE__), eiffel_free (x, __FILE__, __LINE__))
#elif defined LMALLOC_CHECK
#include <stdio.h>
#define eif_malloc(x) eiffel_malloc (x, __FILE__, __LINE__)
#define eif_calloc(x,y) eiffel_calloc (x, y, __FILE__, __LINE__)
#define eif_realloc(x,y) eiffel_realloc (x, y, __FILE__, __LINE__)
#define eif_free(x) eiffel_free (x, __FILE__, __LINE__)
#else
#define eif_malloc(x) eiffel_malloc (x)
#define eif_calloc(x,y) eiffel_calloc (x,y)
#define eif_realloc(x,y) eiffel_realloc (x,y)
#define eif_free(x) eiffel_free (x)
#endif	/* LMALLOC_DEBUG */

#ifdef __cplusplus
extern "C" {
#endif

#if defined LMALLOC_CHECK || defined LMALLOC_DEBUG
RT_LNK Malloc_t eiffel_malloc (size_t nbytes, char *file, int line);
RT_LNK Malloc_t eiffel_calloc (size_t nelem, size_t elsize, char *file, int line) ;
RT_LNK Malloc_t eiffel_realloc (void *ptr, size_t nbytes, char *file, int line);
RT_LNK void eiffel_free (void *ptr, char *s, int l);
#else
RT_LNK Malloc_t eiffel_malloc (size_t nbytes);
RT_LNK Malloc_t eiffel_calloc (size_t nelem, size_t elsize) ;
RT_LNK Malloc_t eiffel_realloc (void *ptr, size_t nbytes);
RT_LNK void eiffel_free (void *ptr);
#endif

#ifdef __cplusplus
}
#endif

#endif /* _eif_lmalloc_h_ */
