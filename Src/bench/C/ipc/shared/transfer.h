/*

  #####  #####     ##    #    #   ####   ######  ######  #####           #    #
    #    #    #   #  #   ##   #  #       #       #       #    #          #    #
    #    #    #  #    #  # #  #   ####   #####   #####   #    #          ######
    #    #####   ######  #  # #       #  #       #       #####    ###    #    #
    #    #   #   #    #  #   ##  #    #  #       #       #   #    ###    #    #
    #    #    #  #    #  #    #   ####   #       ######  #    #   ###    #    #

	Declarations for transfer routines.
*/

#ifndef _transfer_h_
#define _transfer_h_

#include "stream.h" 	/* %%ss added */

extern void tpipe(STREAM *stream);		/* Open transfer "pipe" */
extern char *tread(int *size);		/* Read from the transfer "pipe" */
extern int twrite(void *buffer, int size);		/* Write to the transfer "pipe" */

#ifdef EIF_WIN32
extern void swallow(STREAM *fd, int size);		/* Discard a certain amount of bytes from file */
#else
extern void swallow(int fd, int size);		/* Discard a certain amount of bytes from file */
#endif

#endif
