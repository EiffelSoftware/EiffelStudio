/*

  #####   ####    ####   #        ####           #    #
    #    #    #  #    #  #       #               #    #
    #    #    #  #    #  #        ####           ######
    #    #    #  #    #  #            #   ###    #    #
    #    #    #  #    #  #       #    #   ###    #    #
    #     ####    ####   ######   ####    ###    #    #

	Private general purpose utility functions.
*/

#ifndef _rt_tools_h_
#define _rt_tools_h_

#include "eif_tools.h"

#ifdef __cplusplus
extern "C" {
#endif

extern uint32 nprime(register uint32 n);				/* Find first prime above a given number */
extern int prime(register uint32 n);					/* Test whether a number is prime or not */

#ifdef __cplusplus
}
#endif

#endif
