/*
	WEL_THR_INIT
*/

#include "eif_lmalloc.h"
#include "wel_thr_init.h"

#ifdef EIF_THREADS

#define WEL_TSD_VAL_TYPE		LPVOID
#define WEL_TSD_TYPE            DWORD

/* Thread Specific Data management */
#define WEL_TSD_CREATE(key,msg) \
	if ((key=TlsAlloc())==0xFFFFFFFF) eraise(msg, EN_EXT)
#define WEL_TSD_SET(key,val,msg) \
	if (!TlsSetValue((key),(WEL_TSD_VAL_TYPE)(val))) eraise(msg, EN_EXT)
#define WEL_TSD_GET0(val_type,key,val) \
 	val=val_type TlsGetValue(key)
#define WEL_TSD_GET(val_type,key,val,msg) \
	WEL_TSD_GET0(val_type,key,val);	\
	if (GetLastError() != NO_ERROR) eraise(msg, EN_EXT)
#define WEL_TSD_DESTROY(key,msg) \
	if (!TlsFree(key)) eraise(msg, EN_EXT)


void wel_thr_register(void);
void wel_init_context(wel_global_context_t *);

rt_private EIF_BOOLEAN volatile is_wel_global_key_created = 0;
WEL_TSD_TYPE wel_global_key = (WEL_TSD_TYPE) 0;

void wel_thr_register(void)
{
	/*
	 * Allocates memory for the wel_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 * Allocates memory for onces (for non-root threads)
	 */

	wel_global_context_t *wel_globals;

	if ((is_wel_global_key_created == 0) && (wel_global_key == (WEL_TSD_TYPE) 0)) {
		is_wel_global_key_created = 1;
		WEL_TSD_CREATE(wel_global_key,"Couldn't create global key for root thread");

		wel_globals = (wel_global_context_t *)eif_malloc(sizeof(wel_global_context_t));
		if (!wel_globals) eif_thr_panic("No more memory for thread context");
		wel_init_context(wel_globals);
		WEL_TSD_SET(wel_global_key,wel_globals,"Couldn't bind context to TSD.");
	}
}

void wel_init_context(wel_global_context_t *wel_globals)
{
	/*
	 * Clears the eif_globals structure and initializes some of its
	 * fields.
	 */

/* disptchr.c */
	wel_wndproc=NULL;
	wel_dlgproc=NULL;
	dispatcher=NULL;

/* enumfont.c */

	wel_enum_font_fam_procedure=NULL;
	font_family_enumerator=NULL;

/* estream.c */
	
	wel_editstream_in_procedure=NULL;
	wel_editstream_out_procedure=NULL;
}



#endif /* WEL_THR_INIT */
