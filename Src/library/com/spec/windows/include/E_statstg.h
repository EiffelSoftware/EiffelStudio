//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_statstg.h
//
//  Contents:	Declaration of STATSTG structure wrapping class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_STATSTG_H_INC__
#define __ECOM_E_STATSTG_H_INC__

#include <objidl.h>
#include <stdlib.h> 
#include <malloc.h>

class E_STATSTG
{
public:
	// Commands
	E_STATSTG(STATSTG * p_statstg);
	~E_STATSTG();
					
	// Queries
	LPWSTR ccom_name ();
	int ccom_is_same_name(LPWSTR other_name);
	DWORD ccom_type();
	ULARGE_INTEGER * ccom_size ();
	FILETIME * ccom_modification_t ();
	FILETIME * ccom_creation_t ();
	FILETIME * ccom_access_t ();
	DWORD ccom_mode ();
	DWORD ccom_locks_supported ();
	CLSID * ccom_clsid ();
private:
	STATSTG * pSTATSTG;

};

#endif // !__ECOM_E_STATSTG_H_INC__
