/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
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
RT_LNK Malloc_t eiffel_malloc (register size_t nbytes, char *file, int line);
RT_LNK Malloc_t eiffel_calloc (size_t nelem, size_t elsize, char *file, int line) ;
RT_LNK Malloc_t eiffel_realloc (void *ptr, size_t nbytes, char *file, int line);
RT_LNK void eiffel_free (void *ptr, char *s, int l);
#else
RT_LNK Malloc_t eiffel_malloc (register size_t nbytes);
RT_LNK Malloc_t eiffel_calloc (size_t nelem, size_t elsize) ;
RT_LNK Malloc_t eiffel_realloc (void *ptr, size_t nbytes);
RT_LNK void eiffel_free (void *ptr);
#endif

#ifdef __cplusplus
}
#endif

#endif /* _eif_lmalloc_h_ */
