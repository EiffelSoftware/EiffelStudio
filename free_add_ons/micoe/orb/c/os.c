#include "os.h"
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include <dlfcn.h>

#if PLATFORM == linux
#define HAVE_GETTIMEOFDAY_TWOARGS 1;
#elif PLATFORM == alpha
#define HAVE_GETTIMEOFDAY_TWOARGS 1;
#endif

static char strbuf[1024];

EIF_INTEGER MICO_getpid(void)
{
    return (EIF_INTEGER) getpid();
}
/******************************************************/

EIF_POINTER MICO_tempnam (void)
{
    char* tnam = tempnam ((char*)0, "MICO_");

    if (tnam)
        strcpy (strbuf, tnam);
    else
        return (EIF_POINTER)0;

    return (EIF_POINTER) strbuf;
}
/******************************************************/

EIF_INTEGER MICO_get_time (void)
{
    struct timeval tv;

#ifdef HAVE_GETTIMEOFDAY_TWOARGS
    gettimeofday (&tv, (struct timezone*)0);
#else
    gettimeofday (&tv);
#endif

    return (EIF_INTEGER) (tv.tv_sec * 1000L + tv.tv_usec / 1000L);
}
/******************************************************/

#ifndef RTLD_NOW
#define RTLD_NOW 1
#endif

#ifndef RTLD_GLOBAL
#define RTLD_GLOBAL 0
#endif

EIF_POINTER MICO_dlopen (EIF_POINTER nm)

{

   return (EIF_POINTER)0;
    /* We're not ready for this yet. */
    /* Read all about this in emacs info. */
    /* return (EIF_POINTER) dlopen ((char*) nm, RTLD_NOW|RTLD_GLOBAL); */
}
/******************************************************/
/*
The next two are dummies to fill in until I've found the real ones.
*/

EIF_POINTER MICO_dlsym (EIF_POINTER hdl,
                        EIF_POINTER sym)

{
    return (EIF_POINTER)0;
}

/******************************************************/

EIF_POINTER MICO_dlerror (void)

{
    return (EIF_POINTER)0;
}






