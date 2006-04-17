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


#include "E_IRootStorage.h"

// Commands
//---------------------------------------------------------------------

E_IRootStorage::~E_IRootStorage ()
{
  if (pIRootStorage != NULL)
  pIRootStorage->Release();
};
//---------------------------------------------------------------------
void E_IRootStorage::ccom_switch_to_file (EIF_POINTER filename)

// Copies the current file associated with the storage object 
// to a new file. The new file is then used for the storage 
// object and any uncommitted changes.
{
  HRESULT hr;
  hr = pIRootStorage->SwitchToFile ((WCHAR *)filename);
  if (hr != S_OK)
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};

//---------------------------------------------------------------------
E_IRootStorage::E_IRootStorage (IUnknown * pstgName)

// Set `pIRootStorage' to known pointer to IRootStorage
{
  HRESULT hr;

  hr = pstgName->QueryInterface(IID_IRootStorage, (void **)&pIRootStorage);
  if (hr != S_OK)
  {
    pIRootStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  } 
};
//---------------------------------------------------------------------

EIF_POINTER E_IRootStorage::ccom_item()
{
  return (EIF_POINTER)pIRootStorage;
};
