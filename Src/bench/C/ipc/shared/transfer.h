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

extern void tpipe();		/* Open transfer "pipe" */
extern char *tread();		/* Read from the transfer "pipe" */
extern int twrite();		/* Write to the transfer "pipe" */
extern void swallow();		/* Discard a certain amount of bytes from file */

#endif
