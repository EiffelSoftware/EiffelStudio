#ifndef _pstore_h_
#define _pstore_h_

#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Exported features */
extern long store_append (EIF_INTEGER f_desc, char *o, fnptr mid, fnptr nid, char *s);
extern void parsing_store_initialize (void);
extern void parsing_store_dispose (void);
extern void parsing_store (EIF_INTEGER file_desc, EIF_REFERENCE object);

#ifdef __cplusplus
}
#endif

#endif
