//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_IEnumSTATSTG.h
//
//  Contents:	Declaration of IEnumSTATSTG interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_IENUM_STATSTG_H_INC__
#define __ECOM_E_IENUM_STATSTG_H_INC__

#include <objidl.h>
#include <stdlib.h> 
#include <malloc.h>
#include "eif_except.h"
#include "ecom_exception.h"

class E_IEnumSTATSTG
{
public:
	E_IEnumSTATSTG (){};
	~E_IEnumSTATSTG();

	void ccom_initialize_i_enum_ptr (IEnumSTATSTG * p);
	STATSTG * ccom_next ();
	void ccom_skip (ULONG n);
	void ccom_reset();
	IEnumSTATSTG * ccom_clone();
	IEnumSTATSTG * ccom_item();
private:
	IEnumSTATSTG * pIEnum;
	
	
};

#endif // !__ECOM_E_IENUM_STATSTG_H_INC__
