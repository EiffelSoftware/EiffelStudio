/*

  ####    ####   #####    #   #          #    #
 #    #  #    #  #    #    # #           #    #
 #       #    #  #    #     #            ######
 #       #    #  #####      #     ###    #    #
 #    #  #    #  #          #     ###    #    #
  ####    ####   #          #     ###    #    #

	Include file for source file copy.c
*/

#ifndef _eif_copy_h_
#define _eif_copy_h_

#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Functions declarations
 */

RT_LNK EIF_REFERENCE eclone(register EIF_REFERENCE source);			/* Clone of an Eiffel object */
RT_LNK EIF_REFERENCE edclone(EIF_CONTEXT EIF_REFERENCE source);			/* Deep clone of an Eiffel object */
RT_LNK EIF_REFERENCE rtclone(EIF_REFERENCE source);			/* The Eiffel clone operation (run-time) */
RT_LNK void xcopy(EIF_REFERENCE source, EIF_REFERENCE target);			/* Expanded copy with possible exception */
RT_LNK void ecopy(register EIF_REFERENCE source, register EIF_REFERENCE target);			/* Standard copy of a normal Eiffel object */
RT_LNK void eif_std_ref_copy(register EIF_REFERENCE source, register EIF_REFERENCE target);			/* Standard copy of a normal Eiffel object */
RT_LNK EIF_BOOLEAN c_check_assert (EIF_BOOLEAN b);
RT_LNK void spsubcopy(EIF_REFERENCE source, EIF_REFERENCE target, EIF_INTEGER start, EIF_INTEGER end, EIF_INTEGER strchr);		/* Copy special objects' slices */
RT_LNK void spclearall(EIF_REFERENCE spobj);		/* Reset special object's items to default */

#ifdef __cplusplus
}
#endif

#endif
