/*

  ####    ####   #####    #   #          #    #
 #    #  #    #  #    #    # #           #    #
 #       #    #  #    #     #            ######
 #       #    #  #####      #     ###    #    #
 #    #  #    #  #          #     ###    #    #
  ####    ####   #          #     ###    #    #

	Include file for source file copy.c
*/

#ifndef _copy_h_
#define _copy_h_

#include "portable.h"

/* 
 * Functions declarations
 */

public char *eclone();			/* Clone of an Eiffel object */
public char *spclone();			/* Clone for a special object */
public char *edclone();			/* Deep clone of an Eiffel object */
public char *rtclone();			/* The Eiffel clone operation (run-time) */
public void ecopy();			/* Standard copy of a normal Eiffel object */
public void xcopy();			/* Expanded copy with possible exception */
public void spcopy();			/* Standard copy of a special object */

#endif
