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

#ifdef EIF_IL_DLL
#define esys()	eraise("Operating system error", EN_SYS)
#define eio()	eraise("I/O error", EN_IO)
#define eise_io(tag)	eraise(tag, EN_ISE_IO)
#else
extern void esys(void);				/* Raise 'Operating system error' exception */
extern void eio(void);				/* Raise an 'I/O error' exception with default tag */
extern void eise_io(char *tag);		/* Raise an Eiffel 'I/O error' exception with `tag' */
#endif
extern char *error_tag(int code);	/* English description out of errno code */

#ifdef HAS_SYS_ERRLIST
	extern int sys_nerr;            /* Size of sys_errlist[] */
	extern char *sys_errlist[];     /* Maps error code to string */
#endif

#ifdef __cplusplus
}
#endif

#endif
