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

extern void dserver();		/* Main entry point into server mode */
extern void dinterrupt();	/* Wonder if application has been interrupted */
extern char *dview();		/* Computes debugger's view on objects */
extern int debug_mode;
extern void winit();		/* Workbench debugger initialization */

#endif
