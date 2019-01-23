#ifdef EIF_WINDOWS
/* To avoid a warning because _WINSOCKAPI_ is already defined, we remove its definition temporarely. */
#ifdef _WINSOCKAPI_
#undef _WINSOCKAPI_
#define EIF_WINSOCKAPI_OVERRIDE
#endif

#include <winsock2.h>

/* If we have disabled _WINSOCKAPI, we have to restore it in case <winsock2.h> didn't.
 * Also remove EIF_WINSOCKAPI_OVERRIDE as it was just for this current header file. */
#ifdef EIF_WINSOCKAPI_OVERRIDE
#ifndef _WINSOCKAPI_
#define _WINSOCKAPI_
#endif
#undef EIF_WINSOCKAPI_OVERRIDE
#endif

#endif

# include <openssl/bio.h>
# include <openssl/x509.h>
# include <openssl/pem.h>
# include <openssl/err.h>
# include <openssl/ssl.h>
# include <openssl/evp.h>
# include <openssl/tls1.h>
# include <openssl/opensslv.h>
