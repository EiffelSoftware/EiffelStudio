#include <stdio.h>
#include <math.h>
#include <X11/Xlib.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Xutil.h>
#include <X11/Shell.h>
#include <X11/Xos.h>
#include <Xm/Xm.h>
#include "macros.h"
#include "config.h"
#include "argv.h"
#include <sys/types.h>
#include <sys/param.h>

#ifdef I_XM_PROTOCOLS
#include <Xm/Protocols.h>
#else
#include <X11/Protocols.h>
#endif

#ifdef I_SYS_TIMES
#include <sys/times.h>
#endif

#define c_trans_routine "handle_translation" 
							/* 
							 * Must match with routine in callback.c 
							 * for handling translation callbacks.
							 * This is used in MEL to identify the
							 * C callback routine.
							 */
