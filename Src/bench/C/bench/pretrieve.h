#ifndef _pretrieve_h_
#define _pretrieve_h_

rt_public char *partial_retrieve (EIF_INTEGER f_desc, size_t file_size, long position, long nb_obj);
rt_public char *retrieve_all(EIF_INTEGER f_desc, size_t file_size, long position);
rt_public void parsing_retrieve_initialize (void);
rt_public void parsing_retrieve_reset (void);

#endif
