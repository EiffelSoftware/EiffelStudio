/*

  ####    #####  #####   #    #   ####    #####          #    #
 #          #    #    #  #    #  #    #     #            #    #
  ####      #    #    #  #    #  #          #            ######
	  #     #    #####   #    #  #          #     ###    #    #
 #    #     #    #   #   #    #  #    #     #     ###    #    #
  ####      #    #    #   ####    ####      #     ###    #    #

	Private structure definitions.
*/

#ifndef _rt_struct_h_
#define _rt_struct_h_

#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef WORKBENCH
extern int32 **ecall;					/* Updated pointer */
extern struct rout_info *eorg_table;	/* Updated pointer */
extern struct desc_info ***desc_tab;	/* Global descriptor table */

/* Melting Ice technology */
extern unsigned char **melt;				/* Byte code array of melted eiffel features */
extern int *mpatidtab;			/* Table of pattern id's indexed by body id's */

#define Routids(x)	ecall[x]	/* Routine id array */
#endif

#ifdef __cplusplus
}
#endif

#endif
