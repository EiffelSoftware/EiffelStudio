/////////////////////////////////////////////////////////////////////////////
//
//     EIFOLE.H       Copyright (c) 1997 by ISE Inc.
//
//     Version:       0.00
//
//     EiffelCOM Library
//
//     Main header file
//
//     Notes:
//       None.
//

#ifndef __EIFOLE_H_INC__
#define __EIFOLE_H_INC__

#include "eif_eiffel.h"
#include <windows.h>
#include <ole2.h>
#include <olectl.h>
#include <stdio.h>
#include "interfac.h"
#include "wrapfunc.h"
#include "ocxcecil.h"

// Last HRESULT and associated functions

extern HRESULT g_hrStatusCode;
extern int user_error_code;
extern int user_error_facility;
extern int user_result_severity;

//---------------------------------------------------------------------------

extern "C" EIF_BOOLEAN eole2_error_succeeded();
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_last_hresult();
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_last_error_code();
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_last_facility_code();
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_user_hresult();
	
extern "C" void eole2_error_set_error_code (EIF_INTEGER code);
	
extern "C" void eole2_error_set_error_facility (EIF_INTEGER facility);
	
extern "C" void eole2_error_set_result_severity (EIF_BOOLEAN success);

extern "C" void eole2_error_set_last_hresult (EIF_INTEGER code);

//----------------------------------------------------------------------------

// Maximum size for arrays returned by "next" of enumerators.
#define MaxArraySize 256

#endif // !__EIFOLE_H_INC__

/////// END OF FILE /////////////////////////////////////////////////////////
