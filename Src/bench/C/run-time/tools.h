/*

  #####   ####    ####   #        ####           #    #
    #    #    #  #    #  #       #               #    #
    #    #    #  #    #  #        ####           ######
    #    #    #  #    #  #            #   ###    #    #
    #    #    #  #    #  #       #    #   ###    #    #
    #     ####    ####   ######   ####    ###    #    #

	General purpose utility functions.
*/

#ifndef _tools_h_
#define _tools_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "config.h"
#include "portable.h"

extern uint32 nprime(register uint32 n);				/* Find first prime above a given number */
extern int prime(register uint32 n);					/* Test whether a number is prime or not */
extern long hashcode(register char *s, register long int count);				/* Computes hashcode for a string */

#ifdef __cplusplus
}
#endif

#endif
