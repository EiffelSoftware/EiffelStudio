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

extern uint32 nprime();				/* Find first prime above a given number */
extern int prime();					/* Test whether a number is prime or not */
extern long hashcode();				/* Computes hashcode for a string */

#ifdef __cplusplus
}
#endif

#endif
