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

#include "E_bstr.h"

EIF_OBJ bstr_to_eif_obj (BSTR BstrName)

// Transform BSTR into Eiffel STRING object
{
  EIF_OBJ name;
  size_t bstr_size;
  char * str_name;

  if (BstrName != NULL)
  {
    bstr_size = SysStringLen (BstrName);
    str_name = (char *) malloc (bstr_size + 1);

    wcstombs (str_name, BstrName, bstr_size);
    str_name [bstr_size] = '\0';

    name = eif_protect (eif_string (str_name));
    free (str_name);
  }
  else
  {
	name = eif_protect (eif_string (""));
  }
  return name;
};
//----------------------------------------------------------------------------


