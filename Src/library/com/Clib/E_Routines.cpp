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

#include "E_Routines.h"

//------------------------------------------------------------------

int E_Routines::ccom_is_compound_file (WCHAR * pwcsName)

// Indicates whether a particular disk file contains a storage object.
// - pwcsName points to the name of the disk file to be examined, 
//  passed uninterpreted to the underlying file system. 
{
  HRESULT hr;
  int result;

  hr = StgIsStorageFile (pwcsName);
  if (hr == S_OK)
    result = 1;
  else if (hr == S_FALSE)
    result = 0;
  else 
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), EN_COM);
  }
  return result;
};
//------------------------------------------------------------------

//------------------------------------------------------------------
