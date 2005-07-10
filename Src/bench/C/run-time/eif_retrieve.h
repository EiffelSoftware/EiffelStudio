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

/*
	Declarations for retrieve mechanism.
*/

#ifndef _eif_retrieve_h_
#define _eif_retrieve_h_

#include <stdio.h>
#include "eif_globals.h"
#include "eif_cecil.h"

#ifdef __cplusplus
extern "C" {
#endif
 
/* Internal representation of the different kinds of storage */
#define BASIC_STORE '\0'
#define GENERAL_STORE '\01'
#define INDEPENDENT_STORE '\02'
/* TODO: Should this be used instead of INDEPENDENT_STORE? */
#define RECOVERABLE_STORE '\03'

/* Setting of `eif_discard_pointer_values' */
RT_LNK void eif_set_discard_pointer_values(EIF_BOOLEAN);

/* Recoverable storable */
RT_LNK void set_mismatch_information_access (EIF_OBJECT, EIF_PROCEDURE, EIF_PROCEDURE);
RT_LNK void class_translation_put (char *new_name, char *old_name);
RT_LNK void class_translation_clear (void);
RT_LNK EIF_INTEGER class_translation_count (void);
RT_LNK char *class_translation_old (EIF_INTEGER i);
RT_LNK char *class_translation_new (EIF_INTEGER i);

/*
 * Eiffel calls
 */
RT_LNK char *eretrieve(EIF_INTEGER file_desc);		/* Retrieve object store in file */
RT_LNK EIF_REFERENCE stream_eretrieve(EIF_POINTER *, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER *);	/* Retrieve object store in stream */
RT_LNK char *portable_retrieve(int (*char_read_function)(char *, int));

#ifdef __cplusplus
}
#endif

#endif

