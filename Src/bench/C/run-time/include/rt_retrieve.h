/*

 #####   ######  #####  #####    #   ######  #    #  ######          #    #
 #    #  #         #    #    #   #   #       #    #  #               #    #
 #    #  #####     #    #    #   #   #####   #    #  #####           ######
 #####   #         #    #####    #   #       #    #  #        ###    #    #
 #   #   #         #    #   #    #   #        #  #   #        ###    #    #
 #    #  ######    #    #    #   #   ######    ##    ######   ###    #    #

	Declarations for retrieve mechanism.

*/

#ifndef _rt_retrieve_h_
#define _rt_retrieve_h_

#include "eif_retrieve.h"

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_REFERENCE ise_compiler_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos, int (*ret_func) (void));

extern struct htable *rt_table;	/* Table used for solving references */
extern int32 nb_recorded;		/* Number of items recorded in Hector */
extern char rt_kind;
extern char rt_kind_version;

extern int (*retrieve_read_func)(void);

#ifdef __cplusplus
}
#endif

#endif
