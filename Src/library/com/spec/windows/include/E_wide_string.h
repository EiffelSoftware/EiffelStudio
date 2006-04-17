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

#ifndef __ECOM_E_WIDE_STRING_H_INC__
#define __ECOM_E_WIDE_STRING_H_INC__

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "eif_eiffel.h"

#ifdef __cplusplus
  extern "C" {
#endif

WCHAR * ccom_create_from_string (char * string);
EIF_REFERENCE ccom_wide_str_to_string (WCHAR * wide_string);

#ifdef __cplusplus
  }
#endif

#endif // !__ECOM_E_WIDE_STRING_H_INC__
