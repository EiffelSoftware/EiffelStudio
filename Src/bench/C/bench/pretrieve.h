#ifndef _pretrieve_h_
#define _pretrieve_h_

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_REFERENCE partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj);
extern EIF_REFERENCE retrieve_all(EIF_INTEGER f_desc, long position);
extern void parsing_retrieve_initialize (void);
extern EIF_REFERENCE parsing_retrieve (EIF_INTEGER f_desc);

#ifdef __cplusplus
}
#endif

#endif
