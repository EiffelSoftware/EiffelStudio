#ifndef _pstore_h_
#define _pstore_h_

#include "eif_struct.h"

rt_public long store_append (EIF_INTEGER f_desc, char *o, fnptr mid, fnptr nid, char *s);
rt_public void parsing_store_initialize (void);
rt_public void parsing_store_reset (void);

#endif
