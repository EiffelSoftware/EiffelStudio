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

#ifdef __cplusplus
extern "C" {
#endif

class E_IRootStorage
{
public:
	// Commands
	E_IRootStorage(IUnknown * pstgName);
	~E_IRootStorage();
	void ccom_switch_to_file (EIF_POINTER filename);
	
	// Queries	
	EIF_POINTER ccom_item();
	
private:	
	IRootStorage * pIRootStorage;
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_IROOT_STORAGE_H_INC__
