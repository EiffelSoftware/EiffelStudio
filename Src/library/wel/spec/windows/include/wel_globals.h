/*
 #     #  #######  #
 #  #  #  #        #
 #  #  #  #        #
 #  #  #  #####    #
 #  #  #  #        #
 #  #  #  #        #
  ## ##   #######  #######  #######


  ####   #        ####   #####     ##    #        ####          #    #
 #    #  #       #    #  #    #   #  #   #       #              #    #
 #       #       #    #  #####   #    #  #        ####          ######
 #  ###  #       #    #  #    #  ######  #            #   ###   #    #
 #    #  #       #    #  #    #  #    #  #       #    #   ###   #    #
  ####   ######   ####   #####   #    #  ######   ####    ###   #    #
	Global variables handling.

*/

#ifndef __WEL_GLOBALS__
#define __WEL_GLOBALS__


#ifndef __WEL_DISPATCHER__
#	include "disptchr.h"
#endif

#ifndef __WEL_ENUMFONT__
#	include "enumfont.h"
#endif

#ifndef __WEL_EDITSTREAM__
#	include "estream.h"
#endif


#include "eif_portable.h"
#include "eif_constants.h"
#include "eif_types.h"
#include "eif_main.h"

#ifdef EIF_THREADS
#	include "eif_threads.h"
#endif


#ifdef __cplusplus
extern "C" {
#endif



#ifdef EIF_THREADS

/***************************************e
 *                                      *
 *    Reentrant run-time definitions    *
 *                                      *
 ****************************************/


	/*
	 * Definition of the macros WEL_GET_CONTEXT and WEL_END_GET_CONTEXT
	 *
	 * WEL_GET_CONTEXT used to contain an opening curly brace `{'. It is
	 * now changed in order not to need it anymore: it is part of the local
	 * variables declarations.
	 * WEL_END_GET_CONTEXT is now empty
	 */

#define WGTCX \
	wel_global_context_t *wel_globals; \
	wel_thr_register(); \
	wel_globals = (wel_global_context_t *) TlsGetValue (wel_global_key);

#define WEDCX 
	

typedef struct tag_wel_globals		
/* Structure containing all global variables to the run-time */
{

/* disptchr.c */

	EIF_WNDPROC wel_wndproc_cx;
	/* Address of the Eiffel routine `window_procedure' 
	 * (class WEL_DISPATCHER) */
	
	EIF_DLGPROC wel_dlgproc_cx;
	/* Address of the Eiffel routine `dialog_procedure' 
	 * (class WEL_DISPATCHER) */
	
	EIF_OBJ dispatcher_cx;
	/* Address of the Eiffel object WEL_DISPATCHER created 
	 * for each application */

/* enumfont.c */

	EIF_ENUM_FONT_FAMILY_PROCEDURE wel_enum_font_fam_procedure_cx;
	/* Address of the Eiffel routine `converter' 
	 * (class WEL_FONT_FAMILY_ENUMERATOR) */

	EIF_OBJ font_family_enumerator_cx;
	/* Address of the Eiffel object WEL_FONT_FAMILY_ENUMERATOR 
	 * created */

/* estream.c */
	
	EIF_EDITSTREAM_IN_PROCEDURE wel_editstream_in_procedure_cx;
	/* Address of the Eiffel routine `internal_callback' 
	 * (class WEL_EDIT_STREAM_IN) */

	EIF_EDITSTREAM_OUT_PROCEDURE wel_editstream_out_procedure_cx;
	/* Address of the Eiffel routine `internal_callback' 
	 * (class WEL_EDIT_STREAM_OUT) */

} wel_global_context_t;


/* disptchr.c */

#define wel_wndproc	(wel_globals->wel_wndproc_cx)
#define wel_dlgproc	(wel_globals->wel_dlgproc_cx)
#define dispatcher	(wel_globals->dispatcher_cx)

/* enumfont.c */

#define wel_enum_font_fam_procedure		(wel_globals->wel_enum_font_fam_procedure_cx)
#define font_family_enumerator			(wel_globals->font_family_enumerator_cx)

/* estream.c */

#define wel_editstream_in_procedure		(wel_globals->wel_editstream_in_procedure_cx)
#define wel_editstream_out_procedure		(wel_globals->wel_editstream_out_procedure_cx)

	extern EIF_TSD_TYPE wel_global_key;

#else

/******************************************
 *                                        *
 *    Traditional run-time definitions    *
 *                                        *
 ******************************************/

#define WEDCX
#define WGTCX 

/* disptchr.c */

	extern EIF_WNDPROC wel_wndproc;
	extern EIF_DLGPROC wel_dlgproc;
	extern EIF_OBJ dispatcher;

/* enumfont.c */

	extern EIF_ENUM_FONT_FAMILY_PROCEDURE wel_enum_font_fam_procedure;
	extern EIF_OBJ font_family_enumerator;

/* estream.c */

	extern EIF_EDITSTREAM_IN_PROCEDURE wel_editstream_in_procedure;
	extern EIF_EDITSTREAM_OUT_PROCEDURE wel_editstream_out_procedure;

#endif	/* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif	/* _wel_globals_h_ */

