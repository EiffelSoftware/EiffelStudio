#include <stdio.h>
#include "eif_eiffel.h"
#include "matisse_eif.h"

/* Global variables*/
int matisse_exception_code;  /* MATISSE error code */
EIF_TYPE_ID mt_exceptions_type = 0;
EIF_PROC raise_proc;
EIF_PROC from_c_proc;
EIF_PROC string_make_proc;

int Developer_exception = 24;

/*
 * MATISSE exceptions
 */
void c_set_matisse_exception_code(EIF_INTEGER a_code)
{
	matisse_exception_code = a_code;
}

EIF_INTEGER c_matisse_exception_code(void)
{
	return matisse_exception_code;
}


void raise_mt_exception(int status)
{
	EIF_OBJ excp_obj;
	MtConnectionState state;
	
	MtGetConnectionState(&state);
		
	if(mt_exceptions_type == 0){
		EIF_MT_LOG("raise_mt_exception initialize");
		mt_exceptions_type = eif_type_id("MT_EXCEPTIONS");

		/*EIF_MT_LOG3("MT_EXCEPTIONS: %d, EXCEPTIONS: %d, STRING: %d", 
					mt_exceptions_type, exceptions_type, string_type);*/

		/* string_make_proc = eif_proc("make", string_type);
		EIF_MT_LOG("raise_mt_exception initialize: string make \n"); 
		from_c_proc = eif_proc("from_c", string_type);
		EIF_MT_LOG("raise_mt_exception initialize: from_c \n"); */
		/* raise_proc = eif_proc("raise", exceptions_type);*/
		raise_proc = eif_proc("raise_from_c", mt_exceptions_type);
		EIF_MT_LOG("raise_mt_exception initialize: raise_from_c");
	}

	excp_obj = eif_create(mt_exceptions_type);
	/* message_obj = eif_create(string_type);
	(string_make_proc)(eif_access(message_obj), 0);
	(from_c_proc)(eif_access(message_obj), MtError()); */
	c_set_matisse_exception_code(status);
	(raise_proc)(eif_access(excp_obj), MtError(), state);
}