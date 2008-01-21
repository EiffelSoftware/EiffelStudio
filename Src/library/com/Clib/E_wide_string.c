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

#include "E_wide_string.h"

#ifdef __cplusplus
  extern "C" {
#endif

//-------------------------------------------------------------------------

WCHAR * ccom_create_from_string (char * string)

// create E_wide_string from pointer to string
{
  WCHAR * wide_string;
  size_t size, str_size;
  str_size = strlen(string);
  size = mbstowcs(NULL, string, str_size + 1);
  wide_string = (WCHAR *) malloc ((size+1) *(sizeof(WCHAR)));
  mbstowcs(wide_string, string, str_size + 1);
  return wide_string;
};
//--------------------------------------------------------------------------

EIF_REFERENCE ccom_wide_str_to_string (WCHAR * wide_string)

// Convert unicode string to regular string,
// return Eiffel STRING
{
  EIF_OBJ local_obj;
  char * string;
  size_t size, size_wide;

  size_wide = wcslen(wide_string);
  size = wcstombs (NULL, wide_string, size_wide + 1);
  string = (char *)malloc(size + 1);

  wcstombs (string, wide_string, size_wide + 1);
  local_obj = eif_protect(eif_string(string));
  free (string);
  return eif_wean (local_obj);
}
//--------------------------------------------------------------------------

#ifdef __cplusplus
  }
#endif
