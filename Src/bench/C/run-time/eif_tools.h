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

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_config.h"
#include "eif_portable.h"

extern uint32 nprime(register uint32 n);				/* Find first prime above a given number */
extern int prime(register uint32 n);					/* Test whether a number is prime or not */
extern EIF_INTEGER hashcode(register char *s, register EIF_INTEGER count);				/* Computes hashcode for a string */

#ifdef __cplusplus
}
#endif

#endif
