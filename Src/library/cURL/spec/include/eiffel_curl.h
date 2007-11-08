#include <stdio.h>
#include <string.h>

/* unix-specific */
#ifndef EIF_WINNT 
#include <sys/time.h>
#include <unistd.h> 
#endif

#include <curl/curl.h>

#include "eif_main.h"

#ifdef EIF_THREADS
#include "eif_threads.h"
#endif

#ifndef eiffel_curl
#define eiffel_curl

typedef EIF_INTEGER (* EIF_CURL_PROGRESS_PROC) (
#ifndef EIF_IL_DLL
	EIF_OBJECT,     /* CURL_FUNCTION Eiffel object */
#endif
	 EIF_POINTER, /* a_user_pointer */
	 EIF_REAL_64, /* a_dltotal */
	 EIF_REAL_64, /* a_dlnow */
	 EIF_REAL_64, /* a_ultotal */
	 EIF_REAL_64  /* a_ulnow */
	 );
	
typedef EIF_INTEGER (* EIF_CURL_WRITE_PROC) (
#ifndef EIF_IL_DLL
	EIF_OBJECT,     /* CURL_FUNCTION Eiffel object */
#endif
	 EIF_POINTER, /* a_data_pointer */
	 EIF_INTEGER, /* a_size */
	 EIF_INTEGER, /* a_nmemb */
	 EIF_POINTER  /* a_write_pointer */
	 );
	
typedef EIF_INTEGER (* EIF_CURL_DEBUG_PROC) (
#ifndef EIF_IL_DLL
	EIF_OBJECT,     /* CURL_FUNCTION Eiffel object */
#endif
	 EIF_POINTER, /* a_curl_handle */
	 EIF_INTEGER, /* a_curl_infotype */
	 EIF_POINTER	/* a_char_pointer */
	 EIF_INTEGER, /* a_size */
	 EIF_POINTER  /* a_user_pointer */
	 );

EIF_OBJECT eiffel_function_object = NULL;
	/* Address of Eiffel object CURL_FUNCTION */
	
EIF_CURL_PROGRESS_PROC eiffel_progress_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.progress_function */

EIF_CURL_WRITE_PROC eiffel_write_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.write_function */

EIF_CURL_DEBUG_PROC eiffel_debug_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.debug_function */

/* Set Eiffel CURL_FUNCTION object address */
void c_set_object(EIF_OBJECT a_address)
{
	eiffel_function_object = (EIF_OBJECT) eif_adopt (a_address);
}

/* Release Eiffel CURL_FUNCTION object address */
void c_release_object()
{
	eif_wean (eiffel_function_object);
}

/* Set CURL_FUNCTOIN.progress_function address */
void c_set_progress_function_address( EIF_POINTER a_address)
{
	eiffel_progress_function = (EIF_CURL_PROGRESS_PROC) a_address;
}

/* Set CURL_FUNCTOIN.write_function address */
void c_set_write_function_address( EIF_POINTER a_address)
{
	eiffel_write_function = (EIF_CURL_WRITE_PROC) a_address;
}

/* Set CURL_FUNCTOIN.debug_function address */
void c_set_debug_function_address (EIF_POINTER a_address)
{
	eiffel_debug_function = (EIF_CURL_DEBUG_PROC) a_address;
}

/* 	Eiffel adapter function for CURLOPT_WRITEFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_OBJECT. */
size_t curl_write_function (void *ptr, size_t size, size_t nmemb, void *data)
{
	if (eiffel_function_object) {
		return (size_t) ((eiffel_write_function) (
#ifndef EIF_IL_DLL
			(EIF_OBJECT) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) ptr,
			(EIF_INTEGER) size,
			(EIF_INTEGER) nmemb,
			(EIF_POINTER) data));
	} else {
	}  
}

/* 	Eiffel adapter function for CURLOPT_PROGRESSFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_OBJECT. */
size_t curl_progress_function (void * a_object_id, double a_dltotal, double a_dlnow, double a_ultotal, double a_ulnow)
 {
	if (eiffel_function_object) {
		return (size_t) ((eiffel_progress_function) (
#ifndef EIF_IL_DLL
			(EIF_OBJECT) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) a_object_id,
			(EIF_REAL_64) a_dltotal,
			(EIF_REAL_64) a_dlnow,
			(EIF_REAL_64) a_ultotal,
			(EIF_REAL_64) a_ulnow));
	} else {
	}   
 }

/* 	Eiffel adapter function for CURLOPT_DEBUGFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_OBJECT. */ 
size_t curl_debug_function (CURL * a_curl_handle, curl_infotype a_curl_infotype, unsigned char * a_char_pointer, size_t a_size, void * a_object_id)
 {
	if (eiffel_function_object) {
		return (size_t) ((eiffel_debug_function) (
#ifndef EIF_IL_DLL
			(EIF_OBJECT) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) a_curl_handle,
			(EIF_INTEGER) a_curl_infotype,
			(EIF_POINTER) a_char_pointer,
			(EIF_INTEGER) a_size,
			(EIF_POINTER) a_object_id));
	} else {
	}   
 }
 
#endif	
