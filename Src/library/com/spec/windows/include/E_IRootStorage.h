//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_IRootStorage.h
//
//  Contents:	Declaration of IRootStorage interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_IROOT_STORAGE_H_INC__
#define __ECOM_E_IROOT_STORAGE_H_INC__

#include <objidl.h>
#include "eif_cecil.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"

class E_IRootStorage
{
public:
	// Commands
	E_IRootStorage(EIF_POINTER pstgName);
	~E_IRootStorage();
	void ccom_switch_to_file (EIF_POINTER filename);
	
	// Queries	
	EIF_POINTER ccom_iroot_storage();
	
private:	
	IRootStorage * pIRootStorage;
};

#endif // !__ECOM_E_IROOT_STORAGE_H_INC__
