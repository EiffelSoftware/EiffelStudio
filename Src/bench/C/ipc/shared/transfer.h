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
extern int twrite(void *buffer, size_t size);		/* Write to the transfer "pipe" */
extern void end_debug();		/* Free the communication buffer, should be called when debugging stops */

#ifdef EIF_WINDOWS
extern void swallow(STREAM *fd, size_t size);		/* Discard a certain amount of bytes from file */
#else
extern void swallow(int fd, size_t size);		/* Discard a certain amount of bytes from file */
#endif

#endif
