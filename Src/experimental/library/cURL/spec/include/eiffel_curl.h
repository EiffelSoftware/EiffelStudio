/*
indexing
	description: "Functions used by the class CURL_FUNCTION."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eiffel_curl_h_
#define _eiffel_curl_h_

#include "eif_eiffel.h"

/* unix-specific */
#ifndef EIF_WINDOWS 
#include <sys/time.h>
#include <unistd.h> 
#endif

#include <curl/curl.h>

#ifdef __cplusplus
extern "C" {
#endif

extern void c_set_object(EIF_REFERENCE a_address);
extern void c_release_object(void);
extern void c_set_progress_function_address( EIF_POINTER a_address);
extern void c_set_read_function_address( EIF_POINTER a_address);
extern void c_set_write_function_address( EIF_POINTER a_address);
extern void c_set_debug_function_address (EIF_POINTER a_address);
extern size_t curl_write_function (void *ptr, size_t size, size_t nmemb, void *data);
extern size_t curl_read_function (void *ptr, size_t size, size_t nmemb, void *data);
extern size_t curl_progress_function (void * a_object_id, double a_dltotal, double a_dlnow, double a_ultotal, double a_ulnow);
extern size_t curl_debug_function (CURL * a_curl_handle, curl_infotype a_curl_infotype, unsigned char * a_char_pointer, size_t a_size, void * a_object_id);
 
#ifdef __cplusplus
}
#endif

#endif	
