/*

 ######  #    #  #####      #     ####           #    #
 #       #    #  #    #     #    #    #          #    #
 #####   #    #  #####      #    #    #          ######
 #       # ## #  #    #     #    #    #   ###    #    #
 #       ##  ##  #    #     #    #    #   ###    #    #
 ######  #    #  #####      #     ####    ###    #    #

	Fixed communication file descriptors used by processes who (sic)
	wish to have a direct pipeline (sic) with ised.
*/

#ifndef _ewbio_h_
#define _ewbio_h_

/* The following two file descriptors, also known as ewbin and ewbout are
 * arbitrary entries in the file table which are expected to be pre-set when
 * the aplication wants to speak to its parent.
 * It is REALLY important to have the file number for ewbout lesser than the
 * file number used by ewbin, due to the way pipes are opened in the parent.
 */

#define EWBIN	4		/* Process reads from here */
#define EWBOUT	3		/* And writes to there */

#endif

