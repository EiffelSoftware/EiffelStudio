#include "net.h"
#include "curextern.h"

char *error_info() {
	switch (errno) {
		case EWOULDBLOCK:
			strcpy(_concur_error_msg, "Operation would block.");
			break;
		case EINPROGRESS:
			strcpy(_concur_error_msg, "Operation now in progress.");
			break;
		case EALREADY:
			strcpy(_concur_error_msg, "Operation already in progress.");
			break;
		case ENOTSOCK:
			strcpy(_concur_error_msg, "Socket operation on non-socket.");
			break;
		case EDESTADDRREQ:
			strcpy(_concur_error_msg, "Destination address required.");
			break;
		case EMSGSIZE:
			strcpy(_concur_error_msg, "Message too long.");
			break;
		case EPROTOTYPE:
			strcpy(_concur_error_msg, "Protocol wrong type for socket.");
			break;
		case ENOPROTOOPT:
			strcpy(_concur_error_msg, "Protocol not available.");
			break;
		case EPROTONOSUPPORT:
			strcpy(_concur_error_msg, "Protocol not supported.");
			break;
		case ESOCKTNOSUPPORT:
			strcpy(_concur_error_msg, "Socket type not supported.");
			break;
		case EOPNOTSUPP:
			strcpy(_concur_error_msg, "Operation not supported on socket.");
			break;
		case EPFNOSUPPORT:
			strcpy(_concur_error_msg, "Protocol family not supported.");
			break;
		case EAFNOSUPPORT:
			strcpy(_concur_error_msg, "Address family not supported by protocol family.");
			break;
		case EADDRINUSE:
			strcpy(_concur_error_msg, "Address already in use.");
			break;
		case EADDRNOTAVAIL:
			strcpy(_concur_error_msg, "Can't assign requested address.");
			break;
		case ENETDOWN:
			strcpy(_concur_error_msg, "Network is down.");
			break;
		case ENETUNREACH:
			strcpy(_concur_error_msg, "Network is unreachable.");
			break;
		case ENETRESET:
			strcpy(_concur_error_msg, "Network dropped connection on reset.");
			break;
		case ECONNABORTED:
			strcpy(_concur_error_msg, "Software caused connection abort.");
			break;
		case ECONNRESET:
			strcpy(_concur_error_msg, "Connection reset by peer.");
			break;
		case ENOBUFS:
			strcpy(_concur_error_msg, "No buffer space available.");
			break;
		case EISCONN:
			strcpy(_concur_error_msg, "Socket is already connected.");
			break;
		case ENOTCONN:
			strcpy(_concur_error_msg, "Socket is not connected.");
			break;
		case ESHUTDOWN:
			strcpy(_concur_error_msg, "Can't send after socket shutdown.");
			break;
		case ETOOMANYREFS:
			strcpy(_concur_error_msg, "Too many references: can't splice.");
			break;
		case ETIMEDOUT:
			strcpy(_concur_error_msg, "Connection timed out.");
			break;
		case ECONNREFUSED:
			strcpy(_concur_error_msg, "Connection refused.");
			break;
		case ELOOP:
			strcpy(_concur_error_msg, "Too many levels of symbolic links.");
			break;
		case EHOSTDOWN:
			strcpy(_concur_error_msg, "Host is down.");
			break;
		case EHOSTUNREACH:
			strcpy(_concur_error_msg, "No route to host.");
			break;
/*		case EPROCLIM:
			strcpy(_concur_error_msg, "Too many processes.");
			break; */
		case EUSERS:
			strcpy(_concur_error_msg, "Too many users.");
			break;
/*		case EDQUOT:
			strcpy(_concur_error_msg, "Disc quota exceeded.");
			break;*/
		case ESTALE:
			strcpy(_concur_error_msg, "Stale NFS file handle.");
			break;
		case EREMOTE:
			strcpy(_concur_error_msg, "Too many levels of remote in path.");
			break;
		case EMFILE:
			strcpy(_concur_error_msg, "Too many open files.");
			break;
		case 0:
			_concur_error_msg[0] = '\0';
			break;
		default:
			sprintf(_concur_error_msg, "ErrorNo:%d.", errno);
	}
#ifdef EIF_WIN32
	sprintf(_concur_error_msg+strlen(_concur_error_msg), " WSAError = %d.", WSAGetLastError());
#endif
	return _concur_error_msg;
}
