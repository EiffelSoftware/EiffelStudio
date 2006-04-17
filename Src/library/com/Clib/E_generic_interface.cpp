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

#include "E_generic_interface.h"

//--------------------------------------------------------------------------

E_generic_interface::E_generic_interface (IUnknown * other)

// Test if `other' COM interface.
{
  HRESULT hr;
  hr = other->QueryInterface (IID_IUnknown, (void**)&item);
  if (FAILED (hr))
  {
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};
//--------------------------------------------------------------------------

E_generic_interface::~E_generic_interface ()

// Release interface;
{
  if (item != NULL)
    item->Release ();
  item = NULL;
};
//--------------------------------------------------------------------------

EIF_POINTER E_generic_interface::ccom_item ()

// Return pointer to interface.
{
  return (EIF_POINTER)item;
};
//--------------------------------------------------------------------------

