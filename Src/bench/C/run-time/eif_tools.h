/*

  #####   ####    ####   #        ####           #    #
    #    #    #  #    #  #       #               #    #
    #    #    #  #    #  #        ####           ######
    #    #    #  #    #  #            #   ###    #    #
    #    #    #  #    #  #       #    #   ###    #    #
    #     ####    ####   ######   ####    ###    #    #

	General purpose utility functions.
*/

#ifndef _eif_tools_h_
#define _eif_tools_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

extern uint32 nprime(register uint32 n);				/* Find first prime above a given number */
extern int prime(register uint32 n);					/* Test whether a number is prime or not */
RT_LNK EIF_INTEGER hashcode(register char *s, register EIF_INTEGER count);				/* Computes hashcode for a string */

#ifdef __cplusplus
}
#endif

#endif
