/*
	eif_econsole.h - a console for Win32.

*/

#ifndef _eif_econsole_h_
#define _eif_econsole_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

extern void eif_show_console(void);					/* Show the DOS console if needed */
extern void eif_console_cleanup (EIF_BOOLEAN);

#ifdef __cplusplus
}
#endif

#endif /* eif_econsole_h_ */
