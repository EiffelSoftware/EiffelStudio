/*

 #    #  #####   ######  #    #   ####   #    #          #    #
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          ######
 # ## #  #    #  #       #  # #  #       #    #   ###    #    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###    #    #

		Definitions for workbench calls

*/

#ifndef _wbench_h_
#define _wbench_h_

extern char *(*wfeat())();			/* Feature call */
extern char *(*wfeat_inv())();		/* Nested feature call */
extern fnptr wpointer();			/* Feature pointer */
extern long	wattr();				/* Attribute access */
extern long wattr_inv();			/* Nested attribute access */
extern int wtype();					/* Creation type */
extern struct ca_info *wcainfo();	/* Call information structure */
extern void update();				/* Dynamic byte code loading */

#endif
