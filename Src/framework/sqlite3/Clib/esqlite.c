#include "esqlite.h"

int c_esqlite3_commit_callback(void *p_data)
{
	typedef EIF_INTEGER(*EIF_CBFUNC)(
#ifndef EIF_IL_DLL
			EIF_REFERENCE
#endif
		);
	EIF_CBDATAP p_dbdata = (EIF_CBDATAP)p_data;
	EIF_CBFUNC p_func = (EIF_CBFUNC) p_dbdata->func;
	if (p_func != NULL) {
		return (int)(p_func (
#ifndef EIF_IL_DLL
				eif_access (p_dbdata->o)
#endif
			));
	}

	return 0;
}

void c_esqlite3_rollback_callback(void *p_data)
{
	typedef EIF_INTEGER(*EIF_CBFUNC)(
#ifndef EIF_IL_DLL
			EIF_REFERENCE
#endif
		);
	EIF_CBDATAP p_dbdata = (EIF_CBDATAP)p_data;
	EIF_CBFUNC p_func = (EIF_CBFUNC) p_dbdata->func;
	if (p_func != NULL) {
		(p_func (
#ifndef EIF_IL_DLL
				eif_access (p_dbdata->o)
#endif
			));
	}
}

void c_esqlite3_update_callback (void *p_data, int action, char const * db_name, char const *tb_name, sqlite3_int64 row_id)
{
	typedef void(*EIF_CBFUNC)(
#ifndef EIF_IL_DLL
			EIF_REFERENCE,
#endif
			EIF_INTEGER,
			EIF_POINTER,
			EIF_POINTER,
			EIF_INTEGER_64
		);
	EIF_CBDATAP p_dbdata = (EIF_CBDATAP)p_data;
	EIF_CBFUNC p_func = (EIF_CBFUNC) p_dbdata->func;
	if (p_func != NULL) {
		(p_func (
#ifndef EIF_IL_DLL
				eif_access (p_dbdata->o),
#endif
				(EIF_INTEGER)action,
				(EIF_POINTER)db_name,
				(EIF_POINTER)tb_name,
				(EIF_INTEGER_64)row_id
			));
	}
}
