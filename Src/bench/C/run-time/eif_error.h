/*

 ######  #####   #####    ####   #####           #    #
 #       #    #  #    #  #    #  #    #          #    #
 #####   #    #  #    #  #    #  #    #          ######
 #       #####   #####   #    #  #####    ###    #    #
 #       #   #   #   #   #    #  #   #    ###    #    #
 ######  #    #  #    #   ####   #    #   ###    #    #

*/

#ifndef _eif_error_h_
#define _eif_error_h_

#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

/* As a special case, an I/O error is raised when a system call which is
 * I/O bound fails.
 * Obsolete: use `eraise (NULL, EN_IO)' instead
 */
#define eio()	eraise(NULL, EN_IO)

#ifdef __cplusplus
}
#endif

#endif
