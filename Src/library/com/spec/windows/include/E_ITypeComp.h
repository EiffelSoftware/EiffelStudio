//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_ITypeComp.h
//
//  Contents:	Declaration of ITypeComp interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ITYPECOM_H_INC__
#define __ECOM_E_ITYPECOMP_H_INC__

#include <oaidl.h>
#include <oleauto.h>
#include "eif_eiffel.h"
#include "eif_except.h"
#include "ecom_exception.h"

class E_IType_Comp
{
public:
	// Commands
	E_IType_Comp(){};
	E_IType_Comp(ITypeComp * p_i);
	~E_IType_Comp();

	// Queries
	
	ITypeComp * ccom_item(){return pTypeComp;};

private:
	ITypeComp * pTypeComp;	
};

#endif // !__ECOM_E_ITYPECOMP_H_INC__

