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



