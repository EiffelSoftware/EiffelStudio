/*

  ####   ######  #####   #    #  ######  #####           #    #
 #       #       #    #  #    #  #       #    #          #    #
  ####   #####   #    #  #    #  #####   #    #          ######
      #  #       #####   #    #  #       #####    ###    #    #
 #    #  #       #   #    #  #   #       #   #    ###    #    #
  ####   ######  #    #    ##    ######  #    #   ###    #    #

	Declaration of server routines.
*/

#ifndef _server_h_
#define _server_h_

#include "eif_cecil.h" 	/* %%ss added for EIF_OBJ */

extern void dserver(void);		/* Main entry point into server mode */
extern char dinterrupt(void);	/* Wonder if application has been interrupted */
extern char *dview(EIF_OBJ root);	/* Computes debugger's view on objects */
extern int debug_mode;
extern void winit(void);		/* Workbench debugger initialization */

#endif
