#include "eif_net.h"
#include "eif_curextern.h"

char *error_info() {
	char *tmp_ptr;

	tmp_ptr = strerror(errno);
	if (tmp_ptr) {
		strcpy(_concur_error_msg, tmp_ptr);
		strcat(_concur_error_msg, ".");
	} else 
		sprintf(_concur_error_msg, "Unknown error code(%d).", errno);	
#ifdef EIF_WIN32
	sprintf(_concur_error_msg+strlen(_concur_error_msg), " WSAError = %d.", WSAGetLastError());
#endif
	return _concur_error_msg;
}
