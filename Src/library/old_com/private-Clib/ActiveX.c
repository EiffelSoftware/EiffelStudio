/////////////////////////////////////////////////////////////////////////////
//
//     ActiveX.cpp       Copyright (c) 1999 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library
//

#include "ActiveX.h"

EIF_INTEGER c_eole_unregister_typelib (EIF_POINTER a_string, EIF_INTEGER major_v, EIF_INTEGER minor_v, EIF_INTEGER a_syskind)

// Unregister type library with UUID `a_string', major version number `major_v',
// minor version number `minor_v'
// Returns HRESULT
{
	GUID tempGUID;
	HRESULT result;

	EiffelStringToGuid (a_string, &tempGUID);

	result = UnRegisterTypeLib (&tempGUID, major_v, minor_v, 0, (SYSKIND)a_syskind);

	return (EIF_INTEGER)result; 
};
/*--------------------------------------------------------------------------*/

EIF_REFERENCE c_eole_get_path_filename (EIF_POINTER a_file_name)

// Retrieves the full path and filename for the executable file containing the specified module. 	
{
	HMODULE hModule;
	WCHAR lpFilename[300];
	DWORD hr;
	
	hModule = GetModuleHandle (Eif2OleString (a_file_name));
	if (hModule == 0)
	{
		hr = GetLastError();
	}
	hr = GetModuleFileName (hModule, lpFilename, 300);

	return Ole2EifString (lpFilename);	
};
