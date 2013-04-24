/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
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

#include "ecom_runtime.h"

ecom_runtime rt;

void ecom_runtime::ccom_check_hresult ( HRESULT hr )

/*-----------------------------------------------------------
  Checks HRESULT
-----------------------------------------------------------*/
{
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr) == FACILITY_ITF) && eedefined(HRESULT_CODE  (hr) - 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename (HRESULT_CODE (hr) - 1024), NULL), HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_COM);
	};
};
//-------------------------------------------------------------------------