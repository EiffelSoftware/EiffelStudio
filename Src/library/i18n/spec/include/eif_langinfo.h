/* eif_langinfo.h */
/* Use libcharset if on OpenBSD */

#include <langinfo.h>
#ifdef EIF_OS == EIF_OPENBSD
#include <libcharset.h>
#endif