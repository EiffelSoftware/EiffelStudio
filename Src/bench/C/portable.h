/*

 #####    ####   #####    #####    ##    #####   #       ######          #    #
 #    #  #    #  #    #     #     #  #   #    #  #       #               #    #
 #    #  #    #  #    #     #    #    #  #####   #       #####           ######
 #####   #    #  #####      #    ######  #    #  #       #        ###    #    #
 #       #    #  #   #      #    #    #  #    #  #       #        ###    #    #
 #        ####   #    #     #    #    #  #####   ######  ######   ###    #    #

	Some portable declarations.

*/

#ifndef _portable_h_
#define _portable_h_

/*
 * Standard types
 */
#if INTSIZE < 4
typedef int int16;
typedef long int32;
typedef unsigned int uint16;
typedef unsigned long uint32;
#else
typedef short int16;
typedef int int32;
typedef unsigned short uint16;
typedef unsigned int uint32;
#endif

/*
 * Scope control pseudo-keywords
 */
#define public				/* default C scope */
#define private static		/* static outside a block means private */
#define shared				/* data shared between modules, but not public */

#endif
