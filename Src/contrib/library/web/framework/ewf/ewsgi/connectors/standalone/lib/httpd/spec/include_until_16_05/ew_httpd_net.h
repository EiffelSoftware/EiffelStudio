/*
indexing
	description: "Functions used by the EiffelWeb httpd networking classes. "
	copyright:	"Copyright (c) 2011-2016, Jocelyn Fiat, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _ew_httpd_net_h_
#define _ew_httpd_net_h_

#include "eif_config.h"

#ifdef EIF_WINDOWS 
#  ifndef _WINSOCKAPI_
#    define FD_SETSIZE 256
#    include <winsock2.h>
#    include <Ws2tcpip.h>
#    include <stdio.h>
#  endif
#else /* unix-specific */
#  include <sys/socket.h>
#  include <unistd.h> 
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* extern declarations ... */
#ifdef EIF_WINDOWS
extern int setsockopt(int, int, int, char*, int);
extern int recv(int, char *, int, int);
extern int send(int, char *, int, int);
#else
extern int setsockopt(int, int, int, const void*, socklen_t);
extern ssize_t recv(int, void *, size_t, int);
extern ssize_t send(int, const void *, size_t, int);
#endif

#ifdef __cplusplus
}
#endif

#endif	
