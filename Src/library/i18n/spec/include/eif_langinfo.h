/* eif_langinfo.h */
/* Use libcharset if on OpenBSD */

#include <langinfo.h>
#if EIF_OS == EIF_OS_OPENBSD
#include <libcharset.h>
#endif
