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
 * NOTE: do not use low-level numbers like 4/3, since some shells use those
 * descriptors to initialize non-standard redirections (ksh for instance has
 * file #3 redirected on /dev/null and #4 is also defined, although I do not
 * know what for--RAM).
 */

#define EWBIN	8		/* Process reads from here */
#define EWBOUT	7		/* And writes to there */

#endif

