#ifdef EIF_WINDOWS
#ifdef _WINSOCKAPI_
#undef _WINSOCKAPI_
#endif
#include <winsock2.h>
#endif

# include <openssl/bio.h>
# include <openssl/x509.h>
# include <openssl/pem.h>
# include <openssl/err.h>
# include <openssl/ssl.h>
