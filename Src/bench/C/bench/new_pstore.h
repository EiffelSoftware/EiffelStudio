#ifndef _new_pstore_h_
#define _new_pstore_h_

#include "eif_struct.h"

/* Store features */
rt_public long store_append (EIF_INTEGER f_desc, EIF_REFERENCE o, fnptr mid, fnptr nid, EIF_REFERENCE s);
rt_public void parsing_store_initialize (void);

/* Retrieve features */

rt_public EIF_REFERENCE partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj, long size_to_read);
rt_public EIF_REFERENCE retrieve_all(EIF_INTEGER f_desc, long position);
rt_public void parsing_retrieve_initialize (void);

#endif /* _new_pstore_h_ */
