/****************************************************************
 
                  I M P O R T A N T    N O T I C E
                  --------------------------------
 
    The include file is and only is included once by an application,
because it defines the globals used by concurrent run-time.
At present, we let "server.c" in concurrency include it. So no other
file can include the head files again.
 
****************************************************************/
 
#ifndef _CONCURRENT_SERVER_
#define _CONCURRENT_SERVER_

#include "eif_curglb.h"
#include "eif_curextf.h"

#endif
