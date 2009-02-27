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

#include "eiffel_curl.h"

typedef EIF_INTEGER (* EIF_CURL_PROGRESS_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* CURL_FUNCTION Eiffel object */
#endif
	EIF_POINTER, /* a_user_pointer */
	EIF_REAL_64, /* a_dltotal */
	EIF_REAL_64, /* a_dlnow */
	EIF_REAL_64, /* a_ultotal */
	EIF_REAL_64  /* a_ulnow */
	);
	
typedef EIF_INTEGER (* EIF_CURL_WRITE_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* CURL_FUNCTION Eiffel object */
#endif
	EIF_POINTER, /* a_data_pointer */
	EIF_INTEGER, /* a_size */
	EIF_INTEGER, /* a_nmemb */
	EIF_POINTER  /* a_write_pointer */
	);

typedef EIF_INTEGER (* EIF_CURL_READ_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* CURL_FUNCTION Eiffel object */
#endif
	EIF_POINTER, /* a_data_pointer */
	EIF_INTEGER, /* a_size */
	EIF_INTEGER, /* a_nmemb */
	EIF_POINTER  /* a_write_pointer */
	);

	
typedef EIF_INTEGER (* EIF_CURL_DEBUG_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* CURL_FUNCTION Eiffel object */
#endif
	EIF_POINTER, /* a_curl_handle */
	EIF_INTEGER, /* a_curl_infotype */
	EIF_POINTER, /* a_char_pointer */
	EIF_INTEGER, /* a_size */
	EIF_POINTER  /* a_user_pointer */
	);

static EIF_OBJECT eiffel_function_object = NULL;
	/* Address of Eiffel object CURL_FUNCTION */
	
static EIF_CURL_PROGRESS_PROC eiffel_progress_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.progress_function */

static EIF_CURL_WRITE_PROC eiffel_write_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.write_function */
	
static EIF_CURL_READ_PROC eiffel_read_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.read_function */
	
static EIF_CURL_DEBUG_PROC eiffel_debug_function = NULL;
	/* Address of Eiffel CURL_FUNCTION.debug_function */

/* Set Eiffel CURL_FUNCTION object address */
void c_set_object(EIF_REFERENCE a_address)
{
	if (a_address) {
		eiffel_function_object = eif_protect (a_address);
	} else {
		eiffel_function_object = NULL;
	}
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

/* Set CURL_FUNCTOIN.read_function address */
void c_set_read_function_address( EIF_POINTER a_address)
{
	eiffel_read_function = (EIF_CURL_READ_PROC) a_address;
}

/* Set CURL_FUNCTOIN.debug_function address */
void c_set_debug_function_address (EIF_POINTER a_address)
{
	eiffel_debug_function = (EIF_CURL_DEBUG_PROC) a_address;
}

/* 	Eiffel adapter function for CURLOPT_WRITEFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_REFERENCE. */
size_t curl_write_function (void *ptr, size_t size, size_t nmemb, void *data)
{
	if (eiffel_function_object) {
		return (size_t) ((eiffel_write_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) ptr,
			(EIF_INTEGER) size,
			(EIF_INTEGER) nmemb,
			(EIF_POINTER) data));
	} else {
		return 0;
	}  
}

/* 	Eiffel adapter function for CURLOPT_READFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_REFERENCE. */
size_t curl_read_function (void *ptr, size_t size, size_t nmemb, void *data)
{
	if (eiffel_function_object) {
		return (size_t) ((eiffel_read_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) ptr,
			(EIF_INTEGER) size,
			(EIF_INTEGER) nmemb,
			(EIF_POINTER) data));
	} else {
		return 0;
	}  
}


/* 	Eiffel adapter function for CURLOPT_PROGRESSFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_REFERENCE. */
size_t curl_progress_function (void * a_object_id, double a_dltotal, double a_dlnow, double a_ultotal, double a_ulnow)
 {
	if (eiffel_function_object) {
		return (size_t) ((eiffel_progress_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) a_object_id,
			(EIF_REAL_64) a_dltotal,
			(EIF_REAL_64) a_dlnow,
			(EIF_REAL_64) a_ultotal,
			(EIF_REAL_64) a_ulnow));
	} else {
		return 0;
	}   
 }

/* 	Eiffel adapter function for CURLOPT_DEBUGFUNCTION
		We need this function since Eiffel function call need first parameter is EIF_REFERENCE. */ 
size_t curl_debug_function (CURL * a_curl_handle, curl_infotype a_curl_infotype, unsigned char * a_char_pointer, size_t a_size, void * a_object_id)
 {
	if (eiffel_function_object) {
		return (size_t) ((eiffel_debug_function) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access (eiffel_function_object),
#endif
			(EIF_POINTER) a_curl_handle,
			(EIF_INTEGER) a_curl_infotype,
			(EIF_POINTER) a_char_pointer,
			(EIF_INTEGER) a_size,
			(EIF_POINTER) a_object_id));
	} else {
		return 0;
	}   
 }
