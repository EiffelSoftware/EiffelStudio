#ifndef _pretrieve_h_
#define _pretrieve_h_

rt_public EIF_REFERENCE partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj);
rt_public EIF_REFERENCE retrieve_all(EIF_INTEGER f_desc, long position);
rt_public void parsing_retrieve_initialize (void);

#endif
